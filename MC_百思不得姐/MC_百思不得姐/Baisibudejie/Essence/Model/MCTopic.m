//
//  MCTopic.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopic.h"
#import "MCComment.h"
#import "MCUser.h"
#import <MJExtension.h>

@implementation MCTopic
{
    CGFloat _cellHeight;
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
//    if ([key isEqualToString:@"image0"]) {
//        self.small_image = value;
//    }
//    if ([key isEqualToString:@"image1"]) {
//        self.middle_image = value;
//    }
//    if ([key isEqualToString:@"image2"]) {
//        self.large_image = value;
//    }
//}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]" //,
             //             @"qzone_uid" : @"top_cmt[0].user.qzone_uid"
             };
}



- (NSString *)create_time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [formatter dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *component = [[NSDate date] deltaFromDate:create];
            if (component.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",component.hour];
            }else if (component.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前",component.minute];
            }else {
                return @"刚刚";
            }
        }else if(create.isYesterday){
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:create];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:create];
        }
    }else {
        return _create_time;
    }
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        CGSize contentSize = CGSizeMake(MCScreenWidth - 2 * MCTopicCellMargin, MAXFLOAT);
        CGRect rect = [self.text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                            NSFontAttributeName:[UIFont systemFontOfSize:14],
                                            NSForegroundColorAttributeName:[UIColor grayColor]                                           }
                                              context:nil];
        MCLog(@"---%lf",rect.size.height);
        _cellHeight = MCTopicCellTextY + rect.size.height + MCTopicCellMargin;
        
        
        if (self.type == MCTopicTypePicture) {
            if (self.width != 0 && self.height != 0) {
                /** 图片高度 */
                CGFloat pictureW = contentSize.width;
               
                CGFloat pictureH = pictureW * 1.0 * self.height / self.width;
                
                if (pictureH >= MCTopicCellPictureMaxH) {
                    pictureH = MCTopicCellPictureBreakH;
                    _bigPicture = YES;
                }else{
                    _bigPicture = NO;
                }
                
                CGFloat pictureY = MCTopicCellTextY + rect.size.height + MCTopicCellMargin;
                _pictureF = CGRectMake(MCTopicCellMargin, pictureY, pictureW, pictureH);
                
                _cellHeight = _cellHeight + pictureH + MCTopicCellMargin;
            }
            
 
        }else if (self.type == MCTopicTypeVideo) {
            CGFloat videoX = MCTopicCellMargin;
            CGFloat videoY = MCTopicCellTextY + rect.size.height + MCTopicCellMargin;
            CGFloat videoW = contentSize.width;
          
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
        
            _cellHeight = _cellHeight + videoH + MCTopicCellMargin;
        
        }else if (self.type == MCTopicTypeVoice) {
            CGFloat voiceX = MCTopicCellMargin;
            CGFloat voiceY = MCTopicCellTextY + rect.size.height + MCTopicCellMargin;
            CGFloat voiceW = contentSize.width;
  
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + MCTopicCellMargin;
            
        }
        
        if (self.top_cmt) {
           
//            NSMutableArray *mutableArray = [NSMutableArray array];
//            for (NSDictionary *dictionary in self.top_cmt) {
//                MCComment *comment = [[MCComment alloc] init];
//                [comment setValuesForKeysWithDictionary:dictionary];
//                [mutableArray addObject:comment];
//            }
//            self.top_comment = [mutableArray copy][0];
//
////            MCLog(@"%@",self.top_comment.user);
//            MCUser *user = [[MCUser alloc] init];
//            [user setValuesForKeysWithDictionary:self.top_cmt[0][@"user"]];
//            self.top_comment.user = user;
            
            NSString *text = [NSString stringWithFormat:@"%@: %@",self.top_cmt.user.username,self.top_cmt.content];
            
            CGFloat top_cmtHeight = [text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                NSFontAttributeName : [UIFont systemFontOfSize:13]                                                            } context:nil].size.height;
            _cellHeight += MCTopicCellTopCmtTitleH + top_cmtHeight +MCTopicCellMargin;
        }
        _cellHeight += MCTopicCellBottomBarH + MCTopicCellMargin;
        MCLog(@"%lf",_cellHeight);
    }
    return _cellHeight;
}




@end
