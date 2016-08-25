//  MCTabBarController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/5.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTabBarController.h"
#import "MCEssenceViewController.h"
#import "MCNewViewController.h"
#import "MCMeTVC.h"
#import "MCConcernViewController.h"
#import "MCNavigationController.h"
#import "MCTabBar.h"

@interface MCTabBarController ()


@end

@implementation MCTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectedAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
    
//    UIScrollView *scrollView = [UIScrollView appearance];
//    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(MCScreenHeight - 150, 0, MCScreenHeight - 100, 0);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义tabBar
    MCTabBar *tabBar = [[MCTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self setupChildViewControllers];

}
/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    //添加精华控制器
    [self addChildViewController:[[MCEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
   //添加新贴控制器
    [self addChildViewController:[[MCNewViewController alloc] init] title:@"新贴" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    //添加关注控制器
    [self addChildViewController:[[MCConcernViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    //添加我控制器
    [self addChildViewController:[[MCMeTVC alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    MCNavigationController *nav = [[MCNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}

@end
