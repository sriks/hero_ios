//
//  HRGoogleGeocoder.m
//  Hero
//
//  Created by totaramudu on 17/09/15.
//  Copyright © 2015 Deviceworks. All rights reserved.
//

@import CoreLocation;
#import "HRGoogleGeocoder.h"

@interface HRGoogleGeocoder ()
@property (nonatomic) NSURLSession* session;
@end

@implementation HRGoogleGeocoder

- (void)reverseGeocode:(CLLocation *)location withRetries:(int)retries completionHandler:(HRReverseGeocodeCompletionBlock)block {

    if (!self.session) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    NSString* urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f",
                           location.coordinate.latitude,
                           location.coordinate.longitude];
    NSURL* url = [NSURL URLWithString:urlString];
    __weak HRGoogleGeocoder* welf = self;
    
    NSURLSessionDataTask* dataTask =
    [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data,
                                                          NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error) {
            NSError* parsingError;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parsingError];
            NSString* formattedAddress = [welf parseForFormattedAddress:json];
            block(formattedAddress);
        } else {
            block(nil);
        }
    }];
    
    [dataTask resume];
}

- (NSString*)parseForFormattedAddress:(NSDictionary*)json {
    NSString* status = json[@"status"];
    if ([status isEqualToString:@"OK"]) {
        NSArray* result = json[@"results"];
        NSDictionary* topResult = [result firstObject];
        return topResult[@"formatted_address"];
    } else {
        return nil;
    }
}

@end
