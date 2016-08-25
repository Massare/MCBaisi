//
//  MCComment.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCUser;

@interface MCComment : NSObject

@property (nonatomic, copy) NSString *ID;
/** 音频评论时长*/
@property (nonatomic, assign) NSNumber *voicetime;
/** 音频评论的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

//评论用户
@property (nonatomic, strong) MCUser *user;

@end
