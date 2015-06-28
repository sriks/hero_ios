//
//  HRServerManager.h
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRServerProtocol.h"

@interface HRServerManager : NSObject

+ (id<HRServerProtocol>) sharedInstance;

@end
