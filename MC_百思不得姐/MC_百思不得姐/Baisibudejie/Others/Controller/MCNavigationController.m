//
//  MCNavigationController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/5.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCNavigationController.h"

@interface MCNavigationController ()

@end

@implementation MCNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    attribute[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledAttribute = [NSMutableDictionary dictionary];
    disabledAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    disabledAttribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disabledAttribute forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //设置返回按钮
         viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" image:@"navigationButtonReturn" highlightedImage:@"navigationButtonReturnClick" target:self action:@selector(back)];
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
