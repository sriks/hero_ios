//
//  HRWhereAreYouResponseTVC.m
//  Hero
//
//  Created by totaramudu on 15/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServer.h"
#import "HRWhereAreYouResponseTVC.h"

@interface HRWhereAreYouResponseTVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *userInfoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) HRGroupMemberModel* member;
@property (nonatomic) HRWhereAreYouResponse* response;
@end

@implementation HRWhereAreYouResponseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-39, 0, 0, 0);
}

- (void)configureWithMember:(HRGroupMemberModel*)member {
    self.member = member;
    self.userInfoCell.textLabel.text = self.member.name;
    self.userInfoCell.detailTextLabel.text = @"Locating ...";
}

- (void)configureWithResponse:(HRWhereAreYouResponse*)response {
    self.userInfoCell.detailTextLabel.text = @"Located";
    if (!response.formattedAddress)
        self.addressLabel.text = @"";
    else
        self.addressLabel.text = response.formattedAddress;
    
    [self.tableView reloadData];
}

// UITableViewDataSource not required since we are using static cells.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        return 120;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end
