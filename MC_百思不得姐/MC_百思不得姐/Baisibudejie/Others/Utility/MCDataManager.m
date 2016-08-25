//
//  MCDataManager.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/7.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCDataManager.h"
#import "MCRecommandCategory.h"
#import "MCRecommandUser.h"
#import "MCTopic.h"
#import "MCComment.h"

@implementation MCDataManager

//+ (NSArray *)arrayOfObject:(Class)class WithJson:(NSDictionary *)responseObject key:(NSString *)key
//{
//    NSArray *array = responseObject[key];
//    return [[self alloc] objectarrayFromDictionaryarray:array ojbectClass:class];
//}

+ (NSMutableArray *)parseTopicJson:(NSArray *)array
{
    return [[self alloc] objectarrayFromDictionaryarray:array ojbectClass:[MCTopic class]];
}

+ (NSMutableArray *)parseTopCommentJson:(NSArray *)array
{
    return  [[self alloc] objectarrayFromDictionaryarray:array ojbectClass:[MCComment class]];
}


- (NSMutableArray *)objectarrayFromDictionaryarray:(NSArray *)array ojbectClass:(Class)ModelClass
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        id model = [[ModelClass alloc] init];
        [model setValuesForKeysWithDictionary:dictionary];
        [mutableArray addObject:model];
    }
    return mutableArray;
}

@end
