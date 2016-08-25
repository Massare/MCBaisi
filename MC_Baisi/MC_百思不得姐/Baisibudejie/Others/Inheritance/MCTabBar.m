//
//  MCTabBar.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/5.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTabBar.h"
#import "MCPublishVC.h"

@interface MCTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation MCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置tabar的背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        //tabbar添加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        button.size = button.currentBackgroundImage.size;
        [button addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.publishButton = button;
    }
    return self;
}

- (void)publishButtonClick
{
    MCPublishVC *publishVC = [[MCPublishVC alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    static BOOL add = NO;
    
    //设置发布按钮的位置
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publishButton.center = CGPointMake(width*0.5, height*0.5);
    
    //重新布局tabbar的其它按钮
    CGFloat buttonW = width / 5.0;
    CGFloat buttonH = height;
    CGFloat buttonY = 0;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([button isKindOfClass:class]) {
            CGFloat buttonX = index * buttonW;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
            if (index == 2) {
                index++;
            }
            if (add == NO) {
                [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
       
        
    }
    add = YES;
}

- (void)buttonClick {
    [MCNotificationCenter postNotificationName:MCTabBarDidSelectNotification object:nil];
}

@end
