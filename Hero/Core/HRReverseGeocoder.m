//
//  HRReverseGeocoder.m
//  Hero
//
//  Created by totaramudu on 15/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

@import CoreLocation;
#import "HRReverseGeocoder.h"
#import "HRGoogleGeocoder.h"

static HRGoogleGeocoder* sGoogle;

@implementation HRReverseGeocoder

+ (id<HRGeocoderProtocol>)geocoder {
    if (!sGoogle) {
        sGoogle = [[HRGoogleGeocoder alloc] init];
    }
    return sGoogle;
}

+ (void)reverseGeocode:(CLLocation*)location
           withRetries:(int)retries
            completionHandler:(HRReverseGeocodeCompletionBlock)block {
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count) {
            CLPlacemark* placeMark = placemarks.firstObject;
            block([HRReverseGeocoder formattedAddessForPlacemark:placeMark]);
        } else {
            block(nil);
        }
    }];
}

#pragma mark - Private

+ (NSString*)formattedAddessForPlacemark:(CLPlacemark*)placemark {
    NSMutableString* formattedAddress = [NSMutableString string];
    [HRReverseGeocoder appendAddressString:formattedAddress
                                withString:placemark.thoroughfare];
    [HRReverseGeocoder appendAddressString:formattedAddress
                                withString:placemark.subLocality];
    [HRReverseGeocoder appendAddressString:formattedAddress
                                withString:placemark.locality];
    [HRReverseGeocoder appendAddressString:formattedAddress
                                withString:placemark.administrativeArea];
    return formattedAddress;
}

+ (void)appendAddressString:(NSMutableString *)addressString
                 withString:(NSString *)string {
    if (string) {
        if (addressString.length > 0) {
            // it already has some string in it
            [addressString appendString:@", "];
        }
        [addressString appendString:string];
    }
}


@end
