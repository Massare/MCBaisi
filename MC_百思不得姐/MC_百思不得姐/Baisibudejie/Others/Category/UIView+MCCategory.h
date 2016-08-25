//
//  UIView+MCCategory.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MCCategory)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

/** 判断一个控件是否真正显示在主窗口 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

@end
