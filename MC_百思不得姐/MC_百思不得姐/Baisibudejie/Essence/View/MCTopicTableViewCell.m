//
//  MCTopicTableViewCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/8.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopicTableViewCell.h"
#import "MCTopic.h"
#import "MCComment.h"
#import "MCUser.h"
#import <objc/runtime.h>
#import "MCTopicPictureView.h"
#import "MCTopicVoiceView.h"
#import "MCTopicVideoView.h"
#import "MCAlertController.h"
#import "MCShareView.h"
#import "MCAVPlayerView.h"

@interface MCTopicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;

/**顶帖按钮*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**踩帖按钮*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**转发按钮*/
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
/**评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/**图片视图*/
@property (nonatomic, weak) MCTopicPictureView *pictureView;
/**播放音频视图*/
@property (nonatomic, weak) MCTopicVoiceView *voiceView;
/**播放视频的视图*/
@property (nonatomic, weak) MCTopicVideoView *videoView;

/**最热评论的内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;
/**最热评论视图*/
@property (weak, nonatomic) IBOutlet UIView *topCommentView;

@property (nonatomic, strong) MCAVPlayerView *playerView;

@end

@implementation MCTopicTableViewCell



- (MCAVPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [MCAVPlayerView viewFromXib];
        [self addSubview:_playerView];
    }
    return _playerView;
}

- (MCTopicPictureView *)pictureView
{
    if (!_pictureView) {
        MCTopicPictureView *pictureView = [MCTopicPictureView viewFromXib];
        [self addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (MCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        MCTopicVoiceView *voiceView = [MCTopicVoiceView viewFromXib];
        [self addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

//- (MCTopicVideoView *)videoView
//{
//    if (!_videoView) {
//       MCTopicVideoView *videoView = [MCTopicVideoView viewFromXib];
//        [self addSubview:videoView];
//        _videoView = videoView;
//    }
//    return _videoView;
//}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.playerView reset];
}

- (void)awakeFromNib {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
}

- (void)setTopic:(MCTopic *)topic {
    
    _topic = topic;
    
    self.nameLabel.text = topic.name;
    self.creatTimeLabel.text = topic.create_time;
    self.text_Label.text = topic.text;
    [self.profileImageView setHeaderWithUrl:topic.profile_image];
    
    self.sina_vImageView.hidden = !topic.isSina_v;
    
    /**设置按钮文字*/
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    /**根据帖子类型,添加中间的视图*/
    if(topic.type == MCTopicTypePicture){
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.playerView.hidden = YES;
    }else if (topic.type == MCTopicTypeVoice) {
//        self.voiceView.hidden = NO;
//        self.voiceView.topic = topic;
//        self.voiceView.frame = topic.voiceF;
//        
//        self.pictureView.hidden = YES;
//        self.playerView.hidden = YES;
      
        self.playerView.hidden = NO;
        self.playerView.topic = topic;
        self.playerView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
    }else if (topic.type == MCTopicTypeVideo) {
   
        self.playerView.hidden = NO;
        self.playerView.topic = topic;
        self.playerView.frame = topic.videoF;
        
        self.pictureView.hidden = YES;
//        self.voiceView.hidden = YES;
    }else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.playerView.hidden = YES;
    }
    
    /** 最热评论 */
    if (self.topic.top_cmt) {
        self.topCommentView.hidden = NO;
        NSString *string = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = [string rangeOfString:@":"];
        
        [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(0, range.location)];
                                          
        self.topCommentLabel.attributedText = attributedString;
                                    
    }else {
        self.topCommentView.hidden = YES;
    }
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += MCTopicCellMargin;

    frame.size.height = self.topic.cellHeight - MCTopicCellMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

/**点击顶帖按钮*/
- (IBAction)dingButtonClick:(UIButton *)sender {
    
}
/**点击踩帖按钮*/
- (IBAction)caiButtonClick:(UIButton *)sender {
    
}
/**点击转发按钮*/
- (IBAction)repostButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        [MCShareView showShareView];
    }];
    
}
/**点击评论按钮*/
- (IBAction)commentButtonClick:(UIButton *)sender {
    
}
/**点击收藏举报按钮*/
- (IBAction)collectAndReportButtonClick:(UIButton *)sender {
    
    MCAlertController *actionSheetController = [[MCAlertController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheetController animated:YES completion:nil];
}



@end
