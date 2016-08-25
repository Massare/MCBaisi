//
//  MCTopicTableViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
/**  */

#import "MCTopicTableViewController.h"
#import "MCTopicTableViewCell.h"
#import <AFNetworking.h>
#import "MCTopic.h"
#import "MCComment.h"
#import "MCDataManager.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MCCommentVC.h"
#import "MCNewViewController.h"

@interface MCTopicTableViewController ()

/** 帖子数组 */
@property (nonatomic, strong) NSMutableArray *topicArray;
/**  */
@property (nonatomic, copy) NSString *maxtime;
/**当前页码*/
@property (nonatomic, assign) NSInteger currentPage;
/**帖子数量*/
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, assign) NSInteger lastIndex;

@end

static NSString * const MCTopicIdentifier = @"topic";

@implementation MCTopicTableViewController

- (NSMutableArray *)topicArray
{
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化设置
    [self setupTableView];
    //设置刷新控件
    [self setupRefresh];


    
}

- (NSString *)model {
    
    return [self.parentViewController isKindOfClass:[MCNewViewController class]] ? @"newlist": @"list";
}

/** 加载更多的帖子*/
- (void)loadMoreTopic {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    NSInteger page = self.currentPage + 1;
    parameters[@"page"] = @(page);
    parameters[@"type"] = @(self.topicType);
    self.params = parameters;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //[responseObject writeToFile:@"Users/Austen/Desktop/a.plist" atomically:YES];
        if (self.params != parameters) return;
        /**转换成模型数组*/
        NSArray *topicArray = [MCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];;
        [self.topicArray addObjectsFromArray:topicArray];
        /**  */
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
       
        
        /** 数据加载成功页码才+1 */
        self.currentPage = page;
    
        [self checkFooterStatus];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parameters) return;
        [self.tableView.mj_footer endRefreshing];
    }];
}
/** 加载新贴 */
- (void)loadNewTopic {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.topicType);
    self.params = parameters;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        [responseObject writeToFile:@"Users/Austen/Desktop/a.plist" atomically:YES];
        
        if (self.params != parameters) return;
        /** 转换成帖子模型数组 */
        self.topicArray = [MCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        /** 参数maxtime */
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.total = [responseObject[@"info"][@"count"] integerValue];
        /** 刷新数据 */
        [self.tableView reloadData];
        
        self.currentPage = 0;
        /** 停止头部刷新 */
        [self.tableView.mj_header endRefreshing];
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parameters) return;
        /** 停止头部刷新 */
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)checkFooterStatus {
   
    self.tableView.mj_footer.hidden = (self.topicArray.count == 0);
    if (self.topicArray.count < self.total) {
        [self.tableView.mj_footer endRefreshing];
    }else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
/** 设置刷新的hader和footer*/
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    /** 收回时通过alpha自动隐藏 */
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //一开始就进行刷新头
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [self checkFooterStatus];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor clearColor];
    //设置tableView内边距
    CGFloat top = MCTitleViewY + MCTitleViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    CGFloat tops = self.tableView.height * 2.0 / 3;
    CGFloat bottoms = self.tableView.height - tops - 50;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(tops, 0, bottoms, 0);
    //设置分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.rowHeight = 200;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MCTopicTableViewCell class]) bundle:nil] forCellReuseIdentifier:MCTopicIdentifier];
    
    [MCNotificationCenter addObserver:self selector:@selector(tabBarDidSelect) name:MCTabBarDidSelectNotification object:nil];
}

- (void)tabBarDidSelect {
    if (self.lastIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastIndex = self.tabBarController.selectedIndex;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self checkFooterStatus];
    return self.topicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCTopicIdentifier];

    cell.topic = self.topicArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCTopic *topic = self.topicArray[indexPath.row];
    return topic.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    tableView.allowsSelection = NO;
    MCCommentVC *commentVC = [[MCCommentVC alloc] init];
    commentVC.topic = self.topicArray[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    
//    tableView.allowsSelection = YES;
    MCLog(@"---");
}






@end
