//
//  HRWhereAreYouTVC.h
//  Hero
//
//  Created by totaramudu on 08/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HRWhereAreYouDelegate <NSObject>
@required

- (NSArray*)groupMembers;

@end

@interface HRWhereAreYouTVC : UITableViewController

@end
