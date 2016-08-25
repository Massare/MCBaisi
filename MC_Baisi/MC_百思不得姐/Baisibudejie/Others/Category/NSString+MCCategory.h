//
//  NSString+MCCategory.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMTime;

@interface NSString (MCCategory)

+ (NSString *)timeFormatWithTimeString:(NSString *)time;
+ (NSString *)timeFormatWithTimeInterval:(NSTimeInterval)time;

+ (NSString *)timeFormatWithTime:(NSInteger)time;

@end
