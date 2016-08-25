//
//  MCTopicVoiceView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/10.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopicVoiceView.h"
#import "MCProgressView.h"
#import "MCTopicVoiceViewController.h"
#import "MCTopic.h"
#import <UIImageView+WebCache.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>



@interface MCTopicVoiceView ()
/** 音频图片 */
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
/** 播放次数 */
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
/** 播放时长 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@property (weak, nonatomic) IBOutlet MCProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;



@property (nonatomic, strong) AVPlayer *avPlayer;

@end

@implementation MCTopicVoiceView



- (void)awakeFromNib
{
    //禁止自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加点击手势
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVoiceViewController)]];

}

- (void)setTopic:(MCTopic *)topic
{
    _topic = topic;
    self.playButton.hidden = YES;
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = [topic.voicetime intValue] / 60;
    NSInteger second = [topic.voicetime intValue] % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.progressView setProgress:topic.loadProgress animated:YES];
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        topic.loadProgress = 1.0 * receivedSize /expectedSize;
        [self.progressView setProgress:topic.loadProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        self.playButton.hidden = NO;
        
    }];
    
//    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:topic.voiceuri]];
//    
//    self.avPlayer = player;
    
}


- (void)showVoiceViewController {
    MCTopicVoiceViewController *vc = [[MCTopicVoiceViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    

}

- (IBAction)playButtonClick:(id)sender {
    self.playButton.hidden = YES;
    
//    [self.avPlayer play];
//    self.playerContainer.hidden = NO;
    
//    self.playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.topic.voiceuri]];
   
//    [self.playerVC.player play];
}



@end
