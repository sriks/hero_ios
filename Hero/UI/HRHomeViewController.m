//
//  HRHomeViewController.m
//  Hero
//
//  Created by totaramudu on 08/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRHomeViewController.h"
#import "HRWhereAreYouTVC.h"

@interface HRHomeViewController ()
@property (nonatomic) UINavigationController* primaryNavigationController;
@property (nonatomic) UINavigationController* secondaryNavigationController;

@end

@implementation HRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.primaryNavigationController = self.viewControllers.firstObject;
    self.secondaryNavigationController = self.viewControllers.lastObject;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark UISplitViewControllerDelegate

- (void)splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    primaryViewController.view.backgroundColor = [UIColor redColor];
    return YES;
}

@end
