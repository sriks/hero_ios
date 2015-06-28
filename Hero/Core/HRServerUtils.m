//
//  HRServerUtils.m
//  Hero
//
//  Created by totaramudu on 11/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServerUtils.h"

NSString* const kWhereAreYouUriFormat = @"hr://whereareyou?from=%@&target=%@&uid=%@";

@implementation HRServerUtils

+ (NSString*)reqId {
    NSString * uid = [NSString stringWithFormat:@"%08X", arc4random()];
    return uid;
}

+ (NSString*)whereAreYouUriFromRequester:(NSString*)fromId
                                      to:(NSString*)toId
                                     reqId:(NSString*)reqId {
    NSString* uri =
    [NSString stringWithFormat:kWhereAreYouUriFormat, fromId, toId, reqId];
    return uri;
}

@end
