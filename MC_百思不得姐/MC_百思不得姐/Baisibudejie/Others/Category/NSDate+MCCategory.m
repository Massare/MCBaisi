//
//  NSDate+MCCategory.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/9.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "NSDate+MCCategory.h"
#import <SpriteKit/SpriteKit.h>

@implementation NSDate (MCCategory)

- (NSDateComponents *)deltaFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour;
    return [calendar components:unit fromDate:date toDate:self options:0];

}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *nowToday = [formatter stringFromDate:[NSDate date]];
    NSString *selfToday = [formatter stringFromDate:self];
    return [nowToday isEqualToString:selfToday];
}

- (BOOL)isYesterday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate toDate:selfDate options:0];
    return component.year == 0 && component.month == 0 && component.day == 1;
}

@end
