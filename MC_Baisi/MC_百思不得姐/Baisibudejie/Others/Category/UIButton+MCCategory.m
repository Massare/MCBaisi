//
//  UIButton+MCCategory.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/9.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "UIButton+MCCategory.h"

@implementation UIButton (MCCategory)

- (void)setNormalTitle:(NSNumber *)number
{
    [self setTitle:[NSString stringWithFormat:@"%@",number] forState:UIControlStateNormal];
}

@end
