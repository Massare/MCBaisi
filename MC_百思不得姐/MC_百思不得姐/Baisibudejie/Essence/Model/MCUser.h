//
//  MCUser.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUser : NSObject

//昵称
@property (nonatomic, copy) NSString *username;
//性别
@property (nonatomic, copy) NSString *sex;
//头像
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *qq_uid;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *is_vip;
@property (nonatomic, copy) NSString *personal_page;
@property (nonatomic, copy) NSString *qzone_uid;
@property (nonatomic, copy) NSString *weibo_uid;

@end
