//
//  HRLocationVisits.m
//  Hero
//
//  Created by totaramudu on 19/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

@import CoreLocation;
#import <UIKit/UIKit.h>
#import "HRLocationVisits.h"

@import Parse;

@interface HRLocationVisits ()
@property (nonatomic) CLLocationManager* locMgr;
@end

@implementation HRLocationVisits

+ (HRLocationVisits*)startMonitoringVisits {
    HRLocationVisits* instance = [HRLocationVisits new];
    instance.locMgr = [CLLocationManager new];
    instance.locMgr.delegate = instance;
    [instance.locMgr requestAlwaysAuthorization];
    [instance.locMgr startMonitoringVisits];
    CLLocationAccuracy desiredAccuracy = 50 * 1000;
    instance.locMgr.desiredAccuracy = desiredAccuracy;
    [instance.locMgr startUpdatingLocation];
    return instance;
}

+ (HRLocationVisits*)startMonitoringVisitsFromAppLaunchInBackground {
    HRLocationVisits* instance = [HRLocationVisits startMonitoringVisits];
    [instance.locMgr startUpdatingLocation];
    return instance;
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    NSLog(@"didVisitLocation");
    
    NSNumber* state = [NSNumber numberWithInteger:[UIApplication sharedApplication].applicationState];
    if (/*[UIApplication sharedApplication].applicationState == UIApplicationStateBackground*/ true) {
        UILocalNotification* notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Visit alert";
        notification.applicationIconBadgeNumber = 2;
        notification.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        PFObject* obj = [[PFObject alloc] initWithClassName:@"Visits"];
        PFGeoPoint* geoPoint = [PFGeoPoint geoPointWithLatitude:visit.coordinate.latitude
                                                      longitude:visit.coordinate.longitude];
        [obj setObject:geoPoint forKey:@"location"];
        [obj setObject:state forKey:@"app_state"];
        [obj saveInBackground];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
}

@end
