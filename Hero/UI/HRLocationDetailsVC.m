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
@import MapKit;

@interface HRLocationDetailsVC ()
@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@property (nonatomic) HRWhereAreYouResponseTVC* responseTVC;
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
    
    [self.responseTVC configureWithMember:self.groupMember];
    self.title = self.groupMember.name;
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
    
    if ([segue.identifier isEqualToString:@"whereareyou_response"]) {
        self.responseTVC = segue.destinationViewController;
    }
}

#pragma mark - Private

- (void)sendWhereAreYouRequestToMember:(HRGroupMemberModel*)member {
    self.reqId = [[HRServerManager sharedInstance] sendWhereAreYouRequestTo:member];
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
    CLLocation* loc = response.location;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (
                                                                    loc.coordinate,
                                                                    500, 500);
    [self.mapView setRegion:region animated:YES];
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = loc.coordinate;
    [self.mapView addAnnotation:annotation];
    
    [HRReverseGeocoder reverseGeocode:response.location withRetries:1 completionHandler:^(NSString *formattedAddress) {
        self.response.formattedAddress = formattedAddress;
        [self.responseTVC configureWithResponse:self.response];
    }];
}



@end
