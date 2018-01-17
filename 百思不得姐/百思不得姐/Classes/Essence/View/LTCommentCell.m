//
//  LTCommentCell.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/9.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTCommentCell.h"
#import "LTComment.h"
#import "LTUser.h"
#import <UIImageView+WebCache.h>
@interface LTCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;



@end
@implementation LTCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    return NO;
}

- (void)setComment:(LTComment *)comment{
    _comment = comment;
    [self.profileImageView setHeader: comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:LTUserSexMale]? [UIImage imageNamed:@"Profile_manIcon"] :[UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.contentLabel.text = comment.content;
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
        
    }
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = LTTopicCellMargin;
    frame.size.width -= 2*LTTopicCellMargin;
    [super setFrame:frame];
    
    
}
@end
