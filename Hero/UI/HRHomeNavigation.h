//
//  HRHomeNavigation.h
//  Hero
//
//  Created by totaramudu on 14/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@class UINavigationController;
@class HRGroupMemberModel;
@interface HRHomeNavigation : NSObject

+ (HRHomeNavigation*)sharedInstance;

- (UIViewController*)prepareRootNavigationController;
- (UINavigationController*)showLocationRequestForMember:(HRGroupMemberModel*)member;
- (void)showLocationDetailsForResponseUri:(NSString*)responseUri;
- (void)showWhereAreYouResponseNotification:(NSDictionary*)userInfo;

@end
