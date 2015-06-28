//
//  HRServerUtils.h
//  Hero
//
//  Created by totaramudu on 11/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRServerUtils : NSObject

+ (NSString*)reqId;

+ (NSString*)whereAreYouUriFromRequester:(NSString*)fromId
                                      to:(NSString*)toId
                                     reqId:(NSString*)uid;

@end
