//
//  HRLocationDetailsVC.m
//  Hero
//
//  Created by totaramudu on 09/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRLocationDetailsVC.h"
#import "HRWhereAreYouResponseTVC.h"
#import "HRServer.h"
#import "HRDetailsMapViewController.h"

@interface HRLocationDetailsVC ()
@property (nonatomic) HRWhereAreYouResponseTVC* responseTVC;
@property (nonatomic, weak) HRDetailsMapViewController* mapController;
@property (nonatomic, copy) NSString* reqId;
@end

@implementation HRLocationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveWhereAreYouResponse:)
                                                 name:kHRNotificationCenterKeyWhereAreYouResponse object:nil];
    
    if (!self.response) {
        [self sendWhereAreYouRequestToMember:self.groupMember];
    } else {
        [self configureWithResponse:self.response];
    }
    
    self.mapController.groupMember = self.groupMember;
    [self.responseTVC configureWithMember:self.groupMember];
    self.title = self.groupMember.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"whereareyou_response"]) {
        self.responseTVC = segue.destinationViewController;
    } else if([segue.identifier isEqualToString:@"map_controller"]) {
        self.mapController = segue.destinationViewController;
    }
}

#pragma mark - Private

- (void)sendWhereAreYouRequestToMember:(HRGroupMemberModel*)member {
#ifndef TEST_SHOW_DUMMY_DETAILS
    self.reqId = [[HRServerManager sharedInstance] sendWhereAreYouRequestTo:member];
#endif
}

- (void)didReceiveWhereAreYouResponse:(NSNotification*)notification {
    __weak HRLocationDetailsVC* welf = self;
    NSString* uri = notification.userInfo[kHRServerPNKeyAction];
    [[HRServerManager sharedInstance] fetchWhereAreYouResponseForUri:uri completion:^(HRWhereAreYouResponse *response, NSError *error) {
        if (response) {
            welf.response = response;
            [welf configureWithResponse:self.response];
        }
    }];
}

- (void)configureWithResponse:(HRWhereAreYouResponse*)response {
    // Update map
    [self.mapController configure:response.location];
    
    // Update address
    [[HRReverseGeocoder geocoder] reverseGeocode:response.location withRetries:1 completionHandler:^(NSString *formattedAddress) {
        self.response.formattedAddress = formattedAddress;
        [self.responseTVC configureWithResponse:self.response];
    }];
}



@end
