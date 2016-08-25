//
//  MCRecommandCategory.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommandCategory.h"
#import <MJExtension.h>

@implementation MCRecommandCategory

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
//}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
