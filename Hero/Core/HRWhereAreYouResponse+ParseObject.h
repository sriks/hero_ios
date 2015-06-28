//
//  HRWhereAreYouResponse+ParseObject.h
//  Hero
//
//  Created by totaramudu on 13/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRWhereAreYouResponse.h"

@class PFObject;
@interface HRWhereAreYouResponse (ParseObject)

- (void)prepareFromParseObject:(PFObject*)parseObj;

@end
