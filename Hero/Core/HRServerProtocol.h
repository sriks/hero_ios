//
//  HRServerProtocol.h
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HRGroupMemberModel;
@class HRWhereAreYouResponse;

typedef void(^HRFetchGroupMembersBlock)(NSArray* members, NSError* error);
typedef void(^HRFetchMemberBlock)(HRGroupMemberModel* member, NSError* error);
typedef void(^HRFetchWhereAreYouResponseBlock)(HRWhereAreYouResponse* response,
                                               NSError* error);

@protocol HRServerProtocol <NSObject>
@required

- (void)initialize;
- (void)fetchMembersForGroupName:(NSString*)groupName withCompletionBlock:(HRFetchGroupMembersBlock)block;

- (void)fetchMember:(NSString*)memberObjectId withCompletionBlock:(HRFetchMemberBlock)block;

- (NSString*)sendWhereAreYouRequestTo:(HRGroupMemberModel*)groupMember;

- (void)didReceivePushNotification:(NSDictionary*)userInfo;

- (void)fetchWhereAreYouResponseForUri:(NSString*)uri completion:(HRFetchWhereAreYouResponseBlock)block;

@end
