//
//  UIBarButtonItem+MCBarButtonItem.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MCBarButtonItem)

//创建图片按钮
+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
//创建返回按钮
+ (instancetype)itemWithTitle:(NSString *)title image:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
