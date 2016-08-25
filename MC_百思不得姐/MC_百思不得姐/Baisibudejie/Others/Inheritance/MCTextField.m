//
//  MCTextField.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTextField.h"
#import <objc/runtime.h>


@implementation MCTextField

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{
//                                                                                         NSFontAttributeName : self.font,
//                                                                                         NSForegroundColorAttributeName : [UIColor grayColor]
//                                                                                         
//                                                                                    }];
//}

//通过runtime查看类的成员变量 属性等
//+ (void)initialize
//{
//    unsigned int count = 0;
//   Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(ivars + i);
//        //打印所有的成员变量
//        MCLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivars);
//}

- (void)awakeFromNib
{
    //设置光标颜色
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
//    [self setValue:self.textColor forKeyPath:MCPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
//    [self setValue:[UIColor grayColor] forKeyPath:MCPlaceholderColorKeyPath];
    return  [super resignFirstResponder];
}

////
//- (UIColor *)placeholderColor
//{
//    UILabel *label = [self valueForKey:MCPlaceholderColorKeyPath];
//    
//    UIColor *placeholderColor = label.textColor;
//    
//    return _placeholderColor;
//    
//}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    _placeholderColor = placeholderColor;
//    return [self setValue:placeholderColor forKey:MCPlaceholderColorKeyPath];
//}

@end
