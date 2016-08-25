//
//  MCTopic.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MCComment;

@interface MCTopic : NSObject

//帖子类型type
@property (nonatomic, assign) MCTopicType type;
//id
@property (nonatomic, copy) NSString *ID;
//帖子头像地址
@property (nonatomic, copy) NSString *profile_image;
//时否是新浪加v用户
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;
//发帖人昵称
@property (nonatomic, copy) NSString *name;
//创建时间
@property (nonatomic, copy) NSString *create_time;
//帖子内容
@property (nonatomic, copy) NSString *text;
//最热评论
@property (nonatomic, strong) MCComment *top_cmt;

//@property (nonatomic, strong) MCComment *top_comment;
//顶帖数量
@property (nonatomic, assign) NSInteger ding;
//踩帖数量
@property (nonatomic, assign) NSInteger cai;
//转发数量
@property (nonatomic, assign) NSInteger repost;
/**评论数*/
@property (nonatomic, assign) NSInteger comment;

//图片宽度
@property (nonatomic, assign) NSInteger width;
//图片高度
@property (nonatomic, assign) NSInteger height;
//小图片url
@property (nonatomic, copy) NSString *small_image;
//中图片url
@property (nonatomic, copy) NSString *middle_image;
//大图片url
@property (nonatomic, copy) NSString *large_image;

//播放次数
@property (nonatomic, assign) NSInteger playcount;
//视频时长
@property (nonatomic, copy) NSString *videotime;
//视频url
@property (nonatomic, copy) NSString *videouri;

//音频时长
@property (nonatomic, copy) NSString *voicetime;
//音频url
@property (nonatomic, copy) NSString *voiceuri;

/**
 *  辅助属性
 */

/**cell的高度*/
@property (nonatomic, assign,readonly) CGFloat cellHeight;

/**图片控件的frame*/
@property (nonatomic, assign) CGRect pictureF;
/** 图片是不是大图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片下载进度 */
@property (nonatomic, assign) CGFloat loadProgress;


/**音频控件的frame*/
@property (nonatomic, assign) CGRect voiceF;
/**视频控件的frame*/
@property (nonatomic, assign) CGRect videoF;



@end
