//
//  HRWhereAreYouResponse.m
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServer.h"
#import "HRWhereAreYouResponse.h"
#import "HRWhereAreYouResponse+ParseObject.h"

@interface HRWhereAreYouResponse ()
@property (nonatomic, copy) NSDictionary* serverDict;

@property (nonatomic) CLLocation* location;
@property (nonatomic, copy) NSString* respondedBy;
@property (nonatomic) NSDate* updatedAt;
@end

@implementation HRWhereAreYouResponse

- (instancetype)initWithServerDictionary:(NSDictionary*)serverDict {
    self = [super init];
    [self setServerDict:serverDict];
    [self setLocation:serverDict[kHRServerKeyLocation]];
    [self setUpdatedAt:serverDict[kHRServerKeyUpdatedAt]];
    return self;
}

@end
