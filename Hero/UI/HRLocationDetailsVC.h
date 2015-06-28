//
//  HRLocationDetailsVC.h
//  Hero
//
//  Created by totaramudu on 09/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRGroupMemberModel;
@class HRWhereAreYouResponse;
@interface HRLocationDetailsVC : UIViewController

@property (nonatomic) HRGroupMemberModel* groupMember;
@property (nonatomic) HRWhereAreYouResponse* response;

@end
