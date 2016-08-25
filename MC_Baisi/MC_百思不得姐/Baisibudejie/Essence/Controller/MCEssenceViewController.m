//
//  MCEssenceViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/5.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCEssenceViewController.h"
#import "MCRecommendTagViewController.h"
#import "MCTopicTableViewController.h"


@interface MCEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation MCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //添加子控制器
    [self addChildViewControllers];
    //添加
    [self setupContentView];
    //设置标题栏
    [self setupTitleView];
    
}

- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, MCTitleViewY, self.view.width, MCTitleViewH);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
//    NSArray *titleArray = @[@"全部",@"视频",@"音频",@"图片",@"段子"];
    CGFloat buttonW = titleView.width / self.childViewControllers.count;
    CGFloat buttonH = titleView.height;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    for (int i = 0; i < self.childViewControllers.count ; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(i*buttonW, 0, buttonW, buttonH);
        button.tag = i;
        NSString *title = self.childViewControllers[i].title;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];

        if (i == 0) {
            self.selectedButton = button;
            button.enabled = NO;
            [button.titleLabel sizeToFit];
//            MCLog(@"%lf --",button.titleLabel.width);
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}

- (void)titleButtonClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //移动contentView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
   
    scrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    [self.view addSubview:scrollView];
    
    self.contentView = scrollView;
    
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)addChildViewControllers
{
    /**添加段子视图控制器*/
    MCTopicTableViewController *wordVC = [[MCTopicTableViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.topicType = MCTopicTypeWord;
    [self addChildViewController:wordVC];
    /**添加视频视图控制器*/
    MCTopicTableViewController *videoVC = [[MCTopicTableViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.topicType = MCTopicTypeVideo;
    [self addChildViewController:videoVC];
    /**添加音频视图控制器*/
    MCTopicTableViewController *voiceVC = [[MCTopicTableViewController alloc] init];
    voiceVC.title = @"音频";
    voiceVC.topicType = MCTopicTypeVoice;
    [self addChildViewController:voiceVC];
    /** 添加图片视图控制器 */
    MCTopicTableViewController *pictureVC = [[MCTopicTableViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.topicType = MCTopicTypePicture;
    [self addChildViewController:pictureVC];
    /** 添加所有帖子视图控制器*/
    MCTopicTableViewController *allVC = [[MCTopicTableViewController alloc] init];
    allVC.title = @"全部";
    allVC.topicType = MCTopicTypeAll;
    [self addChildViewController:allVC];
}
/**
 *  设置导航栏
 */
- (void)setupNav {
    self.navigationItem.titleView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //添加导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(recommendBarButtonClick)];
    //设置背景颜色
    self.view.backgroundColor = MCGlobalBackgroundColor;
}
/**
 *  点击导航栏左侧按钮
 */
- (void)recommendBarButtonClick
{
    MCRecommendTagViewController *tagVC = [[MCRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma  mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.height = scrollView.height;
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
  
    [scrollView addSubview:vc.view];
    
     NSLog(@"button --- %@",self.titleView.subviews);
    
   
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //标题按钮移动
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleButtonClick:self.titleView.subviews[index]];
}


@end
