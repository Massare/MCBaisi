//
//  MCCommentTableViewCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/11.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCCommentTableViewCell.h"
#import "MCComment.h"
#import "MCUser.h"


@interface MCCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLable;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *voicePlayButton;

@end

@implementation MCCommentTableViewCell

- (BOOL)canBecomeFirstResponder
{
    return  YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(MCComment *)comment
{
    _comment = comment;
    [self.profileImageView setHeaderWithUrl:comment.user.profile_image];
   
    self.sexImageView.image = [comment.user.sex isEqualToString:MCUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.nameLabel.text = comment.user.username;
    self.likeCountLable.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.commentLabel.text = comment.content;
    if (comment.voiceuri.length) {
        self.voicePlayButton.hidden = NO;
        [self.voicePlayButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else {
        self.voicePlayButton.hidden = YES;
    }
    
}
/**点赞*/
- (IBAction)likeButtonClick:(id)sender {
    
    
}

/**音频评论播放*/
- (IBAction)voicePlayButtonClick:(id)sender {
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
