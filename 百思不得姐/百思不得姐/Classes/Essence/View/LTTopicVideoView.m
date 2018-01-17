//
//  LTTopicVideoView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/8.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTTopicVideoView.h"
#import "LTTopic.h"
#import "LTShowPictureViewController.h"
#import <UIImageView+WebCache.h>
@interface LTTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end
@implementation LTTopicVideoView
+ (instancetype)videoView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.userInteractionEnabled = YES;
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    LTShowPictureViewController *vc = [[LTShowPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];

}
- (void)setTopic:(LTTopic *)topic{
    _topic = topic;
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    NSInteger seconds = topic.videotime / 60;
    NSInteger minutes = topic.videotime % 60;
    
    self.videotimeLabel.text = [NSString stringWithFormat:@"%zd:%zd",seconds,minutes];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
    
    
}

@end
