//
//  HRWhereAreYouTVC.m
//  Hero
//
//  Created by totaramudu on 08/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

@import Parse;
#import "HRWhereAreYouTVC.h"
#import "HRServer.h"
#import "HRHomeNavigation.h"

const int HELP_LABEL_HEIGHT = 70;

@interface HRWhereAreYouTVC ()
@property (nonatomic) NSArray* members;
@property (nonatomic, assign) BOOL showHelp;
@property (nonatomic, assign) BOOL isHelpShown;
@end

@implementation HRWhereAreYouTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak HRWhereAreYouTVC* welf = self;
    [[HRServerManager sharedInstance] fetchMembersForGroupName:@"Test" withCompletionBlock:^(NSArray *members, NSError *error) {
        welf.members = members;
        [welf.tableView reloadData];
    }];
    
    self.isHelpShown = YES;
    self.showHelp = YES;
    [self.tableView insertSubview:[self createHelpLabel] atIndex:0];
    [self showHelpLabel];
}

- (UILabel*)createHelpLabel {
    UILabel* helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -HELP_LABEL_HEIGHT, self.view.frame.size.width, HELP_LABEL_HEIGHT)];
    helpLabel.text = @"Tap on a contact to ask Hero to find contact's location.";
    helpLabel.numberOfLines = 0;
    helpLabel.lineBreakMode = NSLineBreakByWordWrapping;
    helpLabel.textAlignment = NSTextAlignmentCenter;
    return helpLabel;
}

- (void)hideHelpLabel {
//    self.tableView.contentInset = UIEdgeInsetsZero;
//    self.isHelpShown = NO;
}

- (void)showHelpLabel {
    self.tableView.contentInset = UIEdgeInsetsMake(HELP_LABEL_HEIGHT, 0, 0, 0);
    self.isHelpShown = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HRGroupMemberModel* member = self.members[indexPath.row];
    cell.textLabel.text = member.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HRGroupMemberModel* member = self.members[indexPath.row];
    [[HRHomeNavigation sharedInstance] showLocationRequestForMember:member];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    if (self.showHelp) {
        if (!self.isHelpShown && scrollView.contentOffset.y < -HELP_LABEL_HEIGHT) {
            [self showHelpLabel];
        }
    } else {
        if (self.isHelpShown && scrollView.contentOffset.y > 0) {
            [self hideHelpLabel];
        }
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"did scroll to top");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    if (scrollView.contentOffset.y > -1) {
        NSLog(@"Hide help text");
        self.showHelp = NO;
    } else if (scrollView.contentOffset.y < -70) {
        NSLog(@"Show help text");
        self.showHelp = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    //    if (self.showHelp)
    //        [self showHelpLabel];
    //    else
    //        [self hideHelpLabel];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
