//
//  HRReverseGeocoder.h
//  Hero
//
//  Created by totaramudu on 15/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HRReverseGeocodeCompletionBlock)(NSString* formattedAddress);

@class CLLocation;
@interface HRReverseGeocoder : NSObject

+ (void)reverseGeocode:(CLLocation*)location
           withRetries:(int)retries
     completionHandler:(HRReverseGeocodeCompletionBlock)block;

@end
