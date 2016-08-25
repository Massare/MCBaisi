//
//  MCCommentVC.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/12.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCCommentVC.h"
#import "MCTopic.h"
#import "MCComment.h"
#import "MCUser.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "MCCommentTableViewCell.h"
#import "MCTopicTableViewCell.h"
#import "MCCommentHV.h"

@interface MCCommentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSArray *hotCommentArray;
@property (nonatomic, strong) NSMutableArray *latestCommentArray;

@property (nonatomic, strong) MCComment *savedComment;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
/**评论总数*/
@property (nonatomic, assign) NSInteger total;
/**页码*/
@property (nonatomic, assign) NSInteger page;


@end

static NSString * const identifier = @"comment";

@implementation MCCommentVC

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeadView];
    
    [self setupRefresh];
}

- (void)setupBasic {
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightedImage:@"comment_nav_item_share_icon_click" target:self action:@selector(shareButtonClick)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangerFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.commentTableView.backgroundColor = MCGlobalBackgroundColor;
    self.commentTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.commentTableView.contentInset = UIEdgeInsetsMake(0, 0, MCTopicCellMargin, 0);
    [self.commentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MCCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    self.commentTableView.estimatedRowHeight = 70;
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)keyboardWillChangerFrame:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomConstraint.constant = MCScreenHeight - frame.origin.y;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
//    // 键盘显示\隐藏完毕的frame
//    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    // 修改底部约束
//    self.bottomSapce.constant = XMGScreenH - frame.origin.y;
//    // 动画时间
//    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    // 动画
//    [UIView animateWithDuration:duration animations:^{
//        [self.view layoutIfNeeded];
//    }];
}

- (void)setupHeadView {
    UIView *header = [[UIView alloc] init];
    
    if (self.topic.top_cmt) {
        self.savedComment = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    MCTopicTableViewCell *topicCell = [MCTopicTableViewCell viewFromXib];
                                       
    topicCell.topic = self.topic;
    topicCell.size = CGSizeMake(MCScreenWidth, self.topic.cellHeight);
    [header addSubview:topicCell];
    header.height = self.topic.cellHeight + MCTopicCellMargin;
    
    self.commentTableView.tableHeaderView = header;
}

- (void)setupRefresh {
    
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self checkFooterStatus];
}

- (void)loadNewComments {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"dataList";
    parameter[@"c"] = @"comment";
    parameter[@"data_id"] = self.topic.ID;
    parameter[@"hot"] = @"1";
    MCLog(@"-------------%lf",self.commentTableView.contentInset.top);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.commentTableView.mj_header endRefreshing];
            return;
        } // 说明没有评论数据
        
        
       
        self.hotCommentArray = [MCComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestCommentArray = [MCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        self.total = [responseObject[@"total"] integerValue];
        [self.commentTableView reloadData];
        
        [self.commentTableView.mj_header endRefreshing];
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.commentTableView.mj_header endRefreshing];
    }];
  
}

- (void)loadMoreComments {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"dataList";
    parameter[@"c"] = @"comment";
    parameter[@"data_id"] = self.topic.ID;
    NSInteger page = self.page + 1;
    parameter[@"page"] = @(page);
    MCComment *comment = [self.latestCommentArray lastObject];
    parameter[@"lastcid"] = comment.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        } // 说明没有评论数据
        
        NSArray *newComments = [MCComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestCommentArray addObjectsFromArray:newComments];
        self.page = page;
        [self.commentTableView reloadData];
        
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkFooterStatus];
    }];
  
}

- (void)checkFooterStatus {
    
    self.commentTableView.mj_footer.hidden = !(self.hotCommentArray.count == 0 && self.latestCommentArray.count == 0);
    if (self.latestCommentArray.count < self.total) {
        [self.commentTableView.mj_footer endRefreshing];
    }else {
        [self.commentTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - tableView代理方法实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotCommentArray.count) return 2;
    if (self.latestCommentArray.count) return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    [self checkFooterStatus];
    
    NSInteger hotCount = self.hotCommentArray.count;
    NSInteger latestCount = self.latestCommentArray.count;
    
    tableView.mj_footer.hidden = (latestCount == 0);
    if (section == 0) {
       return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (indexPath.section == 0) {
//        cell.comment = self.hotCommentArray.count ? self.hotCommentArray[indexPath.row] :self.latestCommentArray[indexPath.row];
//    }
    cell.comment = [self commentsInIndexpath:indexPath];

    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MCCommentHV *headerView = [MCCommentHV headerViewOfSectionWithTableView:tableView];
    if (section == 0) {
        headerView.title = self.hotCommentArray.count ? @"最热评论" : @"最新评论";
    }else {
        headerView.title = @"最新评论";
    }
    return headerView;
}

- (MCComment *)commentsInIndexpath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotCommentArray.count ? self.hotCommentArray : self.latestCommentArray;
    }
    return self.latestCommentArray;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    } else {
        // 被点击的cell
        MCCommentTableViewCell *cell = (MCCommentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        // 出现一个第一响应者
        [cell becomeFirstResponder];
        
        // 显示MenuController
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding, replay, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)ding:(UIMenuController *)menu {
    
}

- (void)report:(UIMenuController *)menu {
    
}

- (void)reply:(UIMenuController *)menu {
    
}

- (IBAction)commentTextFieldClick:(id)sender {
    MCLog(@"commentTextField -- 点击确定");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)dealloc
{
    if (self.savedComment) {
        self.topic.top_cmt = self.savedComment;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    [self.manager invalidateSessionCancelingTasks:YES];
    
}

- (IBAction)voiceButtonClick:(id)sender {
    
}

- (IBAction)mouseButtonClick:(id)sender {
    
}

- (void)shareButtonClick {
    
}







@end
