//
//  HRWhereAreYouResponseTVC.h
//  Hero
//
//  Created by totaramudu on 15/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRGroupMemberModel;
@class HRWhereAreYouResponse;
@interface HRWhereAreYouResponseTVC : UITableViewController

- (void)configureWithMember:(HRGroupMemberModel*)member;
- (void)configureWithResponse:(HRWhereAreYouResponse*)response;

@end
