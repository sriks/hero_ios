//
//  HRDetailsMapViewController.m
//  Hero
//
//  Created by totaramudu on 03/07/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

@import MapKit;
#import "HRDetailsMapViewController.h"
#import "DCCircledLetterView.h"
#import "HRGroupMemberModel.h"

@interface HRDetailsMapViewController ()
@property (nonatomic) BOOL isConfigured;
@property (nonatomic) IBOutlet MKMapView* mapView;
@property (nonatomic) UIView* locatingView;
@end

@implementation HRDetailsMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    if (!self.isConfigured)
        [self showLocatingView];
}

- (void)configure:(CLLocation*)location {
    self.mapView.hidden = NO;
    self.isConfigured = YES;
    [self dismissLocatingView];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (
                                                                    location.coordinate,
                                                                    500, 500);
    [self.mapView setRegion:region animated:YES];
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location.coordinate;
    [self.mapView addAnnotation:annotation];
}

#pragma mark Private

- (void)showLocatingView {
    if (!self.locatingView) {
        self.locatingView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.locatingView.backgroundColor = [UIColor clearColor];
        self.locatingView.center = self.view.center;
        float circleDiameter = 60.0f;
        DCCircledLetterView* circleView = [[DCCircledLetterView alloc] initWithFrame:CGRectMake(0,0,circleDiameter, circleDiameter)];
        circleView.label.text = [self.groupMember.name substringToIndex:1];
        circleView.label.textColor = [UIColor whiteColor];
        circleView.center = self.locatingView.center;
        circleView.fillColor = [UIColor grayColor];
        [self.locatingView addSubview:circleView];
        
        DCCircledLetterView* behindCircle = [[DCCircledLetterView alloc] initWithFrame:circleView.frame];
        behindCircle.fillColor = [UIColor lightGrayColor];
        behindCircle.center = circleView.center;
        [self.locatingView insertSubview:behindCircle belowSubview:circleView];
        [self.view addSubview:self.locatingView];
        
        __weak DCCircledLetterView* weakBehindCircle = behindCircle;
        // Animate
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveEaseInOut animations:^{
            float newWidth = CGRectGetWidth(weakBehindCircle.bounds) + 40;
            CGRect newBounds = weakBehindCircle.bounds;
            newBounds.size.width = newWidth;
            newBounds.size.height = newWidth;
            weakBehindCircle.bounds = newBounds;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    self.locatingView.hidden = NO;
}

- (void)dismissLocatingView {
    self.locatingView.hidden = YES;
}

@end
