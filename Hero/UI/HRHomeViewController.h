//
//  HRHomeViewController.h
//  Hero
//
//  Created by totaramudu on 08/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRHomeViewController : UISplitViewController <UISplitViewControllerDelegate>

@property (nonatomic, readonly) UINavigationController* primaryNavigationController;
@property (nonatomic, readonly) UINavigationController* secondaryNavigationController;

@end
