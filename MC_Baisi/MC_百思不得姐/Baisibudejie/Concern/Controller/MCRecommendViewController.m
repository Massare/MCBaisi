//
//  MCRecommendViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommendViewController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "MCDataManager.h"
#import "MCRecommandCategoryTVCell.h"
#import "MCRecommandUserTVCell.h"
#import "MCRecommandCategory.h"


#define MCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MCRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation MCRecommendViewController

static NSString * const CategoryIdentifier = @"category";
static NSString * const UserIdentifier = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

/**
 * 加载左侧的类别数据
 */
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [MCRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**
 * 控件的初始化
 */
- (void)setupTableView
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MCRecommandCategoryTVCell class]) bundle:nil] forCellReuseIdentifier:CategoryIdentifier];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MCRecommandUserTVCell class]) bundle:nil] forCellReuseIdentifier:UserIdentifier];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = MCGlobalBackgroundColor;
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    MCRecommandCategory *category = MCSelectedCategory;
    
    category.currentPage = 1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    
    parameters[@"category_id"] = @(category.ID);
    parameters[@"page"] = @(category.currentPage);
    
//    MCLog(@"------%ld----%ld",category.ID,category.currentPage);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *usersArray = [MCRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //先清空
        [category.users removeAllObjects];
        //重新加载
        [category.users addObjectsFromArray:usersArray];
        category.total = [responseObject[@"total"] integerValue];
        
        if (self.params != parameters) return;
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.userTableView.mj_header endRefreshing];
        if (self.params != parameters) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
       
    }];
}

- (void)loadMoreUsers
{
    MCRecommandCategory *category = MCSelectedCategory;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.ID);
    NSInteger page = category.currentPage + 1;
    parameters[@"page"] = @(page);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *usersArray = [MCRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:usersArray];
       
        if (self.params != parameters) return;
        
        [self.userTableView reloadData];
        
        category.currentPage = page;
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.userTableView.mj_footer endRefreshing];
        if (self.params != parameters) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
    }];
}


/**
 * 时刻监测mj_footer的状态
 */
- (void)checkFooterState
{
    MCRecommandCategory *category = MCSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
//    MCLog(@"++++%ld",category.users.count);
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    // 让底部控件结束刷新
    if (category.users.count == category.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    [self checkFooterState];
    return [MCSelectedCategory users].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        MCRecommandCategoryTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryIdentifier];
        cell.category = self.categories[indexPath.row];
        return  cell;
    }else {
        MCRecommandUserTVCell *cell = [tableView dequeueReusableCellWithIdentifier:UserIdentifier];
        cell.user = [MCSelectedCategory users][indexPath.row];
        return cell;
    }
  
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    MCRecommandCategory *category = self.categories[indexPath.row];
    if (category.users.count) {
        [self.userTableView reloadData];
        
    }else {
        [self.userTableView reloadData];
        
    [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}



@end
