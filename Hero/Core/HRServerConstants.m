//
//  HRServerConstants.m
//  Hero
//
//  Created by totaramudu on 10/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServerConstants.h"

#pragma mark Server Keys
NSString* const kHRServerObjectId                       =       @"objectId";
NSString* const kHRServerKeyName                        =       @"name";
NSString* const kHRServerKeyGroups                      =       @"groups";

NSString* const kHRServerKeyUpdatedAt                   =       @"updatedAt";
NSString* const kHRServerKeyLocationInfo                =       @"location_info";
NSString* const kHRServerKeyRequestedBy                 =       @"requested_by";
NSString* const kHRServerKeyUserObjectId                =       @"user_objectid";
NSString* const kHRServerKeyLocation                    =       @"location";

#pragma mark Push Notification Keys
NSString* const kHRServerPNKeyAction                    =       @"a";
NSString* const kHRServerPNKeyFrom                      =       @"from";
NSString* const kHRServerPNKeyUid                       =       @"uid";
NSString* const kHRServerPNKeyTarget                    =       @"target";


#pragma mark NotificationCenter Keys
NSString* const kHRNotificationCenterKeyWhereAreYouResponse     =   @"com.deviceworks.hero.notif.whereareyouresponse";