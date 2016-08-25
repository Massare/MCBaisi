//
//  MCRecommandCategory.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRecommandCategory : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger count;


/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger total;

@end
