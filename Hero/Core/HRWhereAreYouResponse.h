//
//  HRWhereAreYouResponse.h
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@interface HRWhereAreYouResponse : NSObject

- (instancetype)initWithServerDictionary:(NSDictionary*)serverDict;

@property (nonatomic, readonly) CLLocation* location;
@property (nonatomic, readonly, copy) NSString* respondedBy;
@property (nonatomic, readonly) NSDate* updatedAt;
@property (nonatomic, copy) NSString* formattedAddress;

@end




