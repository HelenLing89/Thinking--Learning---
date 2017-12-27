//
//  LTTopicCell.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/25.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopicCell.h"
#import "LTTopic.h"
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

@end
@implementation LTTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(LTTopic *)topic{
    _topic = topic;
    self.sinaView.hidden = !topic.isSinaV;
    self.textlabel.text = topic.text;
    [self.profile_Image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.create_time;
    LTLog(@"%@",topic.create_time);
    [self setButton:self.caiButton count:topic.cai placeholder:@"踩"];
    LTLog(@"%zd",topic.cai);
    [self setButton:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButton:self.repostButton count:topic.repost placeholder:@"分享"];
    [self setButton:self.commentButton count:topic.comment placeholder:@"评论"];
    
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
    frame.origin.x += LTTopicCellMargin;
    frame.origin.y += LTTopicCellMargin;
    frame.size.width -= 2*LTTopicCellMargin;
    frame.size.height -= LTTopicCellMargin;
    [super setFrame:frame];
}
@end
