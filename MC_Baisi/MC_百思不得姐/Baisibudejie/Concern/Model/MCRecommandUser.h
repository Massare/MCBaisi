//
//  MCRecommandUser.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRecommandUser : NSObject

//@property (nonatomic, copy) NSString *header;
//@property (nonatomic, copy) NSString *screen_name;
//@property (nonatomic, assign) NSInteger fans_count;

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, copy) NSString *fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
