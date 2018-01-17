//
//  LTTopicCell.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/25.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopicCell.h"
#import "LTTopic.h"
#import "LTComment.h"
#import "LTUser.h"
#import "LTTopicPictureView.h"
#import "LTTopicVoiceView.h"
#import "LTTopicVideoView.h"
#import <UIImageView+WebCache.h>
@interface LTTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profile_Image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaView;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (nonatomic,weak) LTTopicPictureView *pictureView;
@property (nonatomic,weak) LTTopicVoiceView *voiceView;
@property (nonatomic,weak) LTTopicVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topContentLabel;
@end
@implementation LTTopicCell

+(instancetype)cell{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
//    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    [self layoutIfNeeded];
}

- (LTTopicPictureView *) pictureView{
    if (_pictureView == nil) {
        LTTopicPictureView *pictureView = [LTTopicPictureView imageView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        
    }
    return _pictureView;
}

- (LTTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        LTTopicVoiceView *voiceView = [LTTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    
    return _voiceView;
}


- (LTTopicVideoView *)videoView{
    if (_videoView == nil) {
        LTTopicVideoView *videoView = [LTTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(LTTopic *)topic{
    _topic = topic;
    self.sinaView.hidden = !topic.isSinaV;
    self.textlabel.text = topic.text;
    [self.profile_Image setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.create_time;
    LTLog(@"%@",topic.create_time);
    [self setButton:self.caiButton count:topic.cai placeholder:@"踩"];
    LTLog(@"%zd",topic.cai);
    [self setButton:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButton:self.repostButton count:topic.repost placeholder:@"分享"];
    [self setButton:self.commentButton count:topic.comment placeholder:@"评论"];
    if (topic.type == LTTopicTypePicture) {
        self.pictureView.topic = topic;
        CGFloat height = topic.cellHeight;
        self.pictureView.frame = topic.pictureF;
        [self layoutIfNeeded];
    }else if (topic.type == LTTopicTypeVoice) {
        self.voiceView.topic = topic;
        CGFloat height = topic.cellHeight;
        self.voiceView.frame = topic.voiceF;
    }else if (topic.type == LTTopicTypeVideo) {
        self.videoView.topic = topic;
        CGFloat height = topic.cellHeight;
        self.videoView.frame = topic.videoF;
    }
    if (self.topic.top_cmt == nil){
        self.topCommentView.hidden = YES;
    }else{
        self.topCommentView.hidden = NO;
        self.topContentLabel.text = [NSString stringWithFormat:@"%@:%@",self.topic.top_cmt.user.username,self.topic.top_cmt.content];
    }
}

- (void)setButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count >= 10000) {
        placeholder = [NSString stringWithFormat:@"%zd万",count/10000];
    }else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    }


- (void)setFrame:(CGRect)frame{
    frame.origin.x = LTTopicCellMargin;
    frame.origin.y += LTTopicCellMargin;
    frame.size.width = screenW - 2*LTTopicCellMargin;
    frame.size.height -= LTTopicCellMargin;
    [super setFrame:frame];
}

- (IBAction)more:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
//    UIAlertAction *action = [[UIAlertAction alloc] init];
//    action.title = @
    

    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
//    [sheet showInView:self.window];
    
    
}


@end
