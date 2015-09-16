//
//  HRWhereAreYouResponseTVC.m
//  Hero
//
//  Created by totaramudu on 15/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "HRServer.h"
#import "HRWhereAreYouResponseTVC.h"
#import "DCCircledLetterView.h"

const int SECTION_MEMBER_NAME       =   0;
const int SECTION_ADDRESS           =   1;

@interface HRWhereAreYouResponseTVC ()


@property (weak, nonatomic) IBOutlet UIView *userInfoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userInfoTitle;
@property (weak, nonatomic) IBOutlet UILabel *userInfoSubtitle;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic) UIView* memberCircleView;
@property (nonatomic) HRGroupMemberModel* member;
@property (nonatomic) HRWhereAreYouResponse* response;
@end

@implementation HRWhereAreYouResponseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-39, 0, 0, 0);
    self.tableView.scrollEnabled = NO;
}

- (void)configureWithMember:(HRGroupMemberModel*)member {
    self.member = member;
    self.userInfoTitle.text = self.member.name;
    self.userInfoSubtitle.text = @"Locating ...";
    self.memberCircleView = [self imageForMember:self.member];
    self.userInfoImageView.backgroundColor = [UIColor clearColor];
    self.userInfoImageView = self.memberCircleView;
}

- (void)configureWithResponse:(HRWhereAreYouResponse*)response {
    self.response = response;
    self.userInfoSubtitle.text = @"Located";
    if (!response.formattedAddress) {
        self.addressLabel.text = @"";
    } else {
        self.addressLabel.text = response.formattedAddress;
    }
    [self.tableView reloadData];
}

- (UIView*)imageForMember:(HRGroupMemberModel*)member {
    float width = 45;
    DCCircledLetterView* cirlceView = [[DCCircledLetterView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    cirlceView.label.text = [member.name substringToIndex:1];
    return cirlceView;
}

// UITableViewDataSource not required since we are using static cells.

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SECTION_MEMBER_NAME) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"userinfo"];
        return cell;
    } else if (indexPath.section == SECTION_ADDRESS) {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"address"];
        cell.textLabel.text = @"My";
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SECTION_ADDRESS) {
        CGRect newSize =
        [self.addressLabel.text boundingRectWithSize:self.addressLabel.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.addressLabel.font} context:nil];
        
        return newSize.size.height + 40; // additional padding for cell not to look cluttered.
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (!self.response)
        return nil;
    
    if (SECTION_ADDRESS == section) {
        return @"The location and address are approximate to the best accuracy.";
    } else {
        return nil;
    }
}

@end
