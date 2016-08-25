//
//  MCMeTVC.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/14.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCMeTVC.h"
#import "MCSettingTVC.h"
#import "MCMeTVCell.h"
#import "MCMeFooterView.h"

@interface MCMeTVC ()

@property (nonatomic, strong) MCMeFooterView *footerView;

@end

static NSString * const identifier = @"meCell";

@implementation MCMeTVC

- (MCMeFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[MCMeFooterView alloc] init];
    }
    return  _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGFloat y = CGRectGetMaxY(self.footerView.frame);
    MCLog(@"fdshf;sd---%lf",y);

}

- (void)viewWillLayoutSubviews
{
    self.tableView.contentSize = CGSizeMake(MCScreenWidth, CGRectGetMaxY(self.footerView.frame));
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
}

- (void)settingClick {
    MCSettingTVC *settingTVC = [[MCSettingTVC alloc] init];
    [self.navigationController pushViewController:settingTVC animated:YES];
}

- (void)moonClick {
    
}

- (void)setupTableView {
    self.tableView.backgroundColor = MCGlobalBackgroundColor;
   
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
     [self.tableView registerClass:[MCMeTVCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MCTopicCellMargin;
    
    self.tableView.tableFooterView = self.footerView;
   
    self.tableView.contentInset = UIEdgeInsetsMake(MCTopicCellMargin-35, 0, 0, 0);

    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCMeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.section == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.imageView.image = nil;
        cell.textLabel.text = @"离线下载";
    }
    

    

    return cell;
}


@end
