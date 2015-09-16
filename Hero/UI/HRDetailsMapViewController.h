//
//  HRDetailsMapViewController.h
//  Hero
//
//  Created by totaramudu on 03/07/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLocation;
@class HRGroupMemberModel;
@interface HRDetailsMapViewController : UIViewController

- (void)configure:(CLLocation*)location;

@property (nonatomic) HRGroupMemberModel* groupMember;

@end
