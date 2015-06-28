//
//  FirstViewController.m
//  Hero
//
//  Created by totaramudu on 04/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "FirstViewController.h"

@import Parse;
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDaddyButtonClicked:(id)sender {
    NSDictionary *data = @{
                           @"alert":@"Where are you?",
                           @"a": @"hr://whereareyou?from=fromobjid&target=fZhIK5O3Zf"
                           };
    NSArray *channels = @[@"daddy"];
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:channels];
    [push setData:data];
    [push sendPushInBackground];
}
@end
