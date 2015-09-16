//
//  HRHomeNavigation.m
//  Hero
//
//  Created by totaramudu on 14/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRHomeNavigation.h"
#import "HRHomeViewController.h"
#import "HRLocationDetailsVC.h"
#import "HRServer.h"

@import UIKit;

NSString* kStoryboard = @"Home";

@interface HRHomeNavigation ()
@property (nonatomic) HRHomeViewController* homeViewController;
@property (nonatomic) UINavigationController* primaryNavigationController;
@property (nonatomic) UINavigationController* secondaryNavigationController;
@property (nonatomic) UIStoryboard* storyboard;
@end

@implementation HRHomeNavigation

+ (HRHomeNavigation*)sharedInstance {
    static dispatch_once_t token;
    static HRHomeNavigation* navigation = nil;
    dispatch_once(&token, ^{
        navigation = [HRHomeNavigation new];
    });
    return navigation;
}

- (UIViewController*)prepareRootNavigationController {
#ifdef TEST_SHOW_DUMMY_DETAILS
    return [self locationDetailsVC];
#endif

    if (!self.homeViewController) {
        self.storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
        self.homeViewController = (HRHomeViewController*)[self.storyboard instantiateInitialViewController];
    }
    return self.homeViewController;
}

- (UINavigationController*)showLocationRequestForMember:(HRGroupMemberModel*)member {
    HRLocationDetailsVC* details = [self locationDetailsVC];
    details.groupMember = member;
    return [self showInActiveNavigationController:details];
}

- (void)showLocationDetailsForResponseUri:(NSString*)responseUri {
    __weak HRHomeNavigation* welf = self;
    [[HRServerManager sharedInstance] fetchWhereAreYouResponseForUri:responseUri completion:^(HRWhereAreYouResponse *response, NSError *error) {
        HRLocationDetailsVC* details = [self locationDetailsVC];
        // TODO: Set member
        details.response = response;
        [welf showInActiveNavigationController:details];
    }];
}

- (void)showWhereAreYouResponseNotification:(NSDictionary*)userInfo {
    UIViewController* topController = [self activeNavigationController].topViewController;
    if ([topController isKindOfClass:[HRLocationDetailsVC class]]) {
        // Details is already shown.
    } else {
        NSString* uri = userInfo[kHRServerPNKeyAction];
        [self showLocationDetailsForResponseUri:uri];
    }
}

#pragma mark - Private

- (HRLocationDetailsVC*)locationDetailsVC {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"LocationDetails" bundle:nil];
    // TODO: Use protocol.
    HRLocationDetailsVC* details = (HRLocationDetailsVC*)[sb instantiateInitialViewController];
    return details;
}

- (UINavigationController*)showInActiveNavigationController:(UIViewController*)vc {
    UINavigationController* theNavController;
    if (self.homeViewController.isCollapsed) {
        theNavController = self.homeViewController.primaryNavigationController;
        [theNavController pushViewController:vc animated:YES];
    } else {
        theNavController = self.homeViewController.secondaryNavigationController;
        theNavController.viewControllers = @[vc];
    }
    return theNavController;
}

- (UINavigationController*)activeNavigationController {
    if (self.homeViewController.isCollapsed)
        return self.homeViewController.primaryNavigationController;
    else
        return self.homeViewController.secondaryNavigationController;
}

@end
