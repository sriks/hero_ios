//
//  HRServerManager.m
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServerManager.h"
#import "HRParseServer.h"

@implementation HRServerManager

+ (id<HRServerProtocol>) sharedInstance {
    static id<HRServerProtocol> server = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        server = [[HRParseServer alloc] init];
    });
    return server;

}

@end
