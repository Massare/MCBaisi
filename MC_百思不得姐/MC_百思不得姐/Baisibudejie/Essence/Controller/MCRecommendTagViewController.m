//
//  MCRecommendTagViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommendTagViewController.h"
#import "MCRecommendTagTVCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "MCRecommendTag.h"

@interface MCRecommendTagViewController ()

@property (nonatomic, strong) NSArray *tagArray;

@end

static NSString * const identifier = @"tagCell";

@implementation MCRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefreshView];
}

- (void)setupTableView {
    self.title = @"推荐标签";
    self.tableView.backgroundColor = MCGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(MCScreenHeight-150, 0, 100, 0);
    
    self.tableView.rowHeight = 70;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MCRecommendTagTVCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}

- (void)setupRefreshView {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTagsData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadTagsData {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tagArray = [MCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
         [self.tableView.mj_header endRefreshing];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tagArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCRecommendTagTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.recommendTag = self.tagArray[indexPath.row];
    
    return cell;
}




@end
