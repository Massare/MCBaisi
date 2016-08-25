//
//  NSDate+MCCategory.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/9.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MCCategory)

/**日期差值*/
- (NSDateComponents *)deltaFromDate:(NSDate *)date;
/**是否是今年*/
- (BOOL)isThisYear;
/**是否是今天*/
- (BOOL)isToday;
/**是否是昨天*/
- (BOOL)isYesterday;

@end
