//
//  HRLocationVisits.h
//  Hero
//
//  Created by totaramudu on 19/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface HRLocationVisits : NSObject <CLLocationManagerDelegate>

+ (HRLocationVisits*)startMonitoringVisits;

+ (HRLocationVisits*)startMonitoringVisitsFromAppLaunchInBackground;
@end
