//
//  NSArray+ParseConversions.m
//  Hero
//
//  Created by totaramudu on 10/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "NSArray+ParseConversions.h"
#import "HRGroupMemberModel.h"
#import "HRServerConstants.h"

@import Parse;
@implementation NSArray (ParseConversions)

- (NSArray*)toGroupMemberModels {
    NSMutableArray* allMembers = [NSMutableArray array];
    for (PFUser* user in self) {
        HRGroupMemberModel* member = [HRGroupMemberModel new];
        member.name = [user objectForKey:kHRServerKeyName];
        member.userObjectId = user.objectId;
        [allMembers addObject:member];
    }
    return allMembers;
}

@end
