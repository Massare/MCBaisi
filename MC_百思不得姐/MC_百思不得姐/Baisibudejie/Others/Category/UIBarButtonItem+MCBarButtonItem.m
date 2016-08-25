//
//  UIBarButtonItem+MCBarButtonItem.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "UIBarButtonItem+MCBarButtonItem.h"

@implementation UIBarButtonItem (MCBarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
 
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    //设置大小
    button.size = CGSizeMake(70, 30);
    //设置文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //设置图片
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    //设置内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //设置内边距
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[self alloc] initWithCustomView:button];
}

@end
