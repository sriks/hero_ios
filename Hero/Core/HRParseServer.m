//
//  HRParseServer.m
//  Hero
//
//  Created by totaramudu on 10/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRParseServer.h"
#import "HRServer.h"
#import "NSArray+ParseConversions.h"
#import "HRGroupMemberModel.h"


NSString* const kServerCollectionLocations                   =       @"Locations";

@import Parse;

@implementation HRParseServer

- (void)initialize {
    
}

- (void)fetchMembersForGroupName:(NSString*)groupName withCompletionBlock:(HRFetchGroupMembersBlock)block {
    PFQuery* query = [PFUser query];
    [query whereKey:kHRServerKeyGroups containedIn:@[groupName]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            block([objects toGroupMemberModels], nil);
        } else {
            block(nil, error);
        }
    }];
}

- (void)fetchMember:(NSString*)memberObjectId withCompletionBlock:(HRFetchMemberBlock)block {
    PFQuery* query = [PFUser query];
    [query whereKey:kHRServerObjectId equalTo:memberObjectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            block([objects toGroupMemberModels].firstObject, nil);
        } else {
            block(nil, error);
        }
    }];
}

- (NSString*)sendWhereAreYouRequestTo:(HRGroupMemberModel*)groupMember {
    // TODO: Use the same reqid for mutiple requests within a time period.
    NSString* reqId = [HRServerUtils reqId];
    NSString* whereAreYouUri = [HRServerUtils whereAreYouUriFromRequester:@"admin"
                                                                       to:groupMember.userObjectId
                                                                    reqId:[HRServerUtils reqId]];
    NSDictionary *data = @{
                           @"alert":@"Where are you?",
                           @"a":whereAreYouUri
                           };
    
    NSArray *channels = @[groupMember.userObjectId];
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:channels];
    [push setData:data];
    [push sendPushInBackground];
    return reqId;
}

- (void)didReceivePushNotification:(NSDictionary*)userInfo {
    NSString* action = userInfo[kHRServerPNKeyAction];
    if (action) {
        NSNotification* notification = [[NSNotification alloc] initWithName:kHRNotificationCenterKeyWhereAreYouResponse
                                                                     object:nil
                                                                   userInfo:@{kHRServerPNKeyAction: action}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

- (void)fetchWhereAreYouResponseForUri:(NSString*)uri completion:(HRFetchWhereAreYouResponseBlock)block {
    NSURL* url = [NSURL URLWithString:uri];
    NSString* version  = url.lastPathComponent;
    if ([version isEqualToString:@"v1"]) {
        [self fetchWhereAreYouResponseForV1Uri:uri completion:block];
    } else if (!version.length) {
        [self fetchWhereAreYouResponseForLegacyUri:uri completion:block];
    }
}

- (void)fetchWhereAreYouResponseForV1Uri:(NSString*)uri completion:(HRFetchWhereAreYouResponseBlock)block {
    NSURLComponents* comps = [NSURLComponents componentsWithString:uri];
    NSArray* items = comps.queryItems;
    NSPredicate *latitudePredicate = [NSPredicate predicateWithFormat:@"name == 'lat'"];
    NSPredicate *longitudePredicate = [NSPredicate predicateWithFormat:@"name == 'lng'"];
    NSPredicate *fromPredicate      =  [NSPredicate predicateWithFormat:@"name == 'from'"];
    
    NSURLQueryItem* targetItem = [items filteredArrayUsingPredicate:latitudePredicate].firstObject;
    NSString* lat = targetItem.value;
    targetItem = [items filteredArrayUsingPredicate:longitudePredicate].firstObject;
    NSString* lng = targetItem.value;
    targetItem = [items filteredArrayUsingPredicate:fromPredicate].firstObject;
    NSString* fromObjId = targetItem.value;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
    NSMutableDictionary* serverDict = [NSMutableDictionary dictionary];
    serverDict[kHRServerKeyLocation] = location;
    serverDict[kHRServerKeyUpdatedAt] = [NSDate date];
    if (fromObjId)
        serverDict[kHRServerKeyRequestedBy] = fromObjId;
    HRWhereAreYouResponse* response = [[HRWhereAreYouResponse alloc] initWithServerDictionary:serverDict];
    block(response, nil);
}

- (void)fetchWhereAreYouResponseForLegacyUri:(NSString*)uri completion:(HRFetchWhereAreYouResponseBlock)block {
    NSURLComponents* comps = [NSURLComponents componentsWithString:uri];
    NSArray* items = comps.queryItems;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == 'objid'"];
    NSURLQueryItem* targetItem = [items filteredArrayUsingPredicate:predicate].firstObject;
    NSString* objIdToFetch = targetItem.value;
    
    PFQuery* query = [PFQuery queryWithClassName:kServerCollectionLocations];
    [query whereKey:kHRServerObjectId equalTo:objIdToFetch];
    [query findObjectsInBackgroundWithBlock:^(NSArray* array, NSError* error) {
        if (array.count) {
            PFObject* parseObj = array.firstObject;
            NSMutableDictionary* serverDict = [NSMutableDictionary dictionary];
            PFGeoPoint* geoPoint = (PFGeoPoint*)[parseObj valueForKey:kHRServerKeyLocation];
            CLLocation* location = [[CLLocation alloc] initWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
            serverDict[kHRServerKeyLocation] = location;
            serverDict[kHRServerKeyRequestedBy] = [parseObj valueForKey:kHRServerKeyRequestedBy];
            serverDict[kHRServerKeyUpdatedAt] = parseObj.updatedAt;
            serverDict[kHRServerKeyUserObjectId] = [parseObj valueForKey:kHRServerKeyUserObjectId];
            HRWhereAreYouResponse* response = [[HRWhereAreYouResponse alloc] initWithServerDictionary:serverDict];
            block(response, nil);
        } else {
            block(nil, error);
        }
    }];
}

@end
