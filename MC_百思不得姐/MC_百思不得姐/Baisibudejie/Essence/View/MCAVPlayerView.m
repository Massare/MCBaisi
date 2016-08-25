//
//  MCAVPlayerView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCAVPlayerView.h"
#import <UIImageView+WebCache.h>
#import "MCProgressView.h"

@interface MCAVPlayerView ()

@property (weak, nonatomic) IBOutlet UIImageView *avImageView;

@property (weak, nonatomic) IBOutlet UIButton *roundPlayButton;
@property (weak, nonatomic) IBOutlet MCProgressView *loadProgressView;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenButton;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *avTimeLabel;

//- (IBAction)avImageViewTap:(UITapGestureRecognizer *)sender;
//- (IBAction)progressSliderTap:(UITapGestureRecognizer *)sender;

- (IBAction)roundPlayButtonClick:(id)sender;

- (IBAction)playOrPauseButtonClick:(id)sender;
- (IBAction)fullScreenButtonClick:(id)sender;


- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)startSlide:(id)sender;
- (IBAction)slide:(id)sender;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayer *currentPlayer;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, assign) BOOL isShowToolView;



@end

@implementation MCAVPlayerView

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        [self.avImageView.layer addSublayer:self.playerLayer];
    }
    return _playerLayer;
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
  

    self.progressSlider.value = 0;
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"kr-video-player-point"] forState:UIControlStateNormal];
    
    
    self.avImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [self.avImageView addGestureRecognizer:tap];
    
    [self removeProgressTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}


- (void)setTopic:(MCTopic *)topic
{
    _topic = topic;
    self.loadProgressView.hidden = NO;
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    if (topic.type == MCTopicTypeVideo) {
        self.avTimeLabel.text = [NSString timeFormatWithTimeString:topic.videotime];
    }
    if (topic.type == MCTopicTypeVoice) {
        self.avTimeLabel.text = [NSString timeFormatWithTimeString:topic.voicetime];
    }
    
    [self.loadProgressView setProgress:topic.loadProgress animated:YES];
    
    NSURL *url = [NSURL URLWithString:topic.large_image];
    [self.avImageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        topic.loadProgress = 1.0 * receivedSize / expectedSize;
        [self.loadProgressView setProgress:topic.loadProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.loadProgressView.hidden = YES;

        self.avImageView.userInteractionEnabled = YES;
    }];
    
    if (topic.type == MCTopicTypeVoice) {
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:topic.voiceuri]];
    }
    if (topic.type == MCTopicTypeVideo) {
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:topic.videouri]];
    }
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
  
}

- (void)tapImageView {
    [self showAndHideToolView];
    self.playCountLabel.hidden = YES;
    self.avTimeLabel.hidden = YES;
}

- (IBAction)roundPlayButtonClick:(id)sender {
    [self removeProgressTimer];
    
    [self.currentPlayer pause];
    [self showAndHideToolView];
    self.isShowToolView = YES;
    self.roundPlayButton.hidden = YES;
    self.playOrPauseButton.selected = YES;
    self.playCountLabel.hidden = YES;
    self.avTimeLabel.hidden = YES;
    
    [self.player play];
    self.currentPlayer = self.player;
    
    [self addProgressTimer];

}

- (IBAction)playOrPauseButtonClick:(id)sender {
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    [self.currentPlayer pause];
    
    if (self.playOrPauseButton.selected) {
        self.roundPlayButton.hidden = YES;
        [self addProgressTimer];
        [self.player play];
    }else {
        self.roundPlayButton.hidden = NO;
        [self removeProgressTimer];
        [self.player pause];
    }
    self.currentPlayer = self.player;
}

- (IBAction)fullScreenButtonClick:(id)sender {
    
}


- (IBAction)sliderValueChanged:(id)sender {
    
    [self removeProgressTimer];
    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = durationTime * self.progressSlider.value;
    self.timeLabel.text = [self stringWithCurrentTime:currentTime durationTime:durationTime];
//    [self.player seekToTime:CMTimeMake(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)startSlide:(id)sender {
    [self removeProgressTimer];
}

- (IBAction)slide:(id)sender {
    [self addProgressTimer];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    self.playOrPauseButton.selected = YES;
    self.roundPlayButton.hidden = YES;
    [self.player play];
}

- (void)addProgressTimer {
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgressSlider) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)updateProgressSlider {
    self.timeLabel.text = [self timeString];
    self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    
    if (self.progressSlider.value == 1.0) {
        self.progressSlider.value = 0;
        self.playOrPauseButton.selected = NO;
        self.roundPlayButton.hidden = NO;
        [UIView animateWithDuration:2 animations:^{
            self.toolView.alpha = 0;
        }];
        NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
        self.timeLabel.text = [self stringWithCurrentTime:0 durationTime:duration];
        [self.player seekToTime:kCMTimeZero toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        
    }
}

- (NSString *)timeString {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    return [self stringWithCurrentTime:currentTime durationTime:durationTime];

}

- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime durationTime:(NSTimeInterval)durationTime {
    NSInteger currentMin = currentTime / 60;
    NSInteger currentSec = (NSInteger)currentTime % 60;
    
    NSInteger durationMin = durationTime / 60;
    NSInteger durationSec = (NSInteger)durationTime % 60;
    
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec];
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld",durationMin,durationSec];
    
    return [NSString stringWithFormat:@"%@/%@",currentString,durationString];
}


- (void)showToolView {
    [UIView animateWithDuration:0.2 animations:^{
        self.toolView.alpha = 1;
    }];
    self.isShowToolView = YES;
}

- (void)hideToolView {
    [UIView animateWithDuration:0.2 animations:^{
        self.toolView.alpha = 0;
    }];
    self.isShowToolView = NO;
}

- (void)showAndHideToolView {
    [self showToolView];
    [self performSelector:@selector(hideToolView) withObject:nil afterDelay:4];
}

- (void)reset {
    [self.player pause];
    self.roundPlayButton.hidden = NO;
    self.toolView.alpha = 0;
    self.progressSlider.value = 0;
    self.avImageView.image = nil;
    self.playCountLabel.hidden = NO;
    self.avTimeLabel.hidden = NO;
}



//- (IBAction)avImageViewTap:(UITapGestureRecognizer *)sender {
//    self.toolView.alpha = 1.0;
//    self.isShowToolView = YES;
//
//}

//- (IBAction)progressSliderTap:(UITapGestureRecognizer *)sender {
//    CGPoint point = [sender locationInView:sender.view];
//    CGFloat ratio = point.x / self.progressSlider.width;
//    
//    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
//    NSTimeInterval currentTime = durationTime * ratio;
//    
//    [self.player seekToTime:CMTimeMake(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//    self.timeLabel.text = [self stringWithCurrentTime:currentTime durationTime:durationTime];
//    
//    [self addProgressTimer];
//    [self.player play];
//}

@end
