//
//  LTTopicVoiceView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/5.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTTopicVoiceView.h"
#import "LTTopic.h"
#import "LTShowPictureViewController.h"
#import <UIImageView+WebCache.h>
@interface LTTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;


@end

@implementation LTTopicVoiceView

+ (instancetype)voiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    LTShowPictureViewController *vc = [[LTShowPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
          
}
      
      
- (void)setTopic:(LTTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        UIGraphicsBeginImageContextWithOptions(topic.voiceF.size, YES, 0.0);
//        CGFloat width = topic.voiceF.size.width;
//        CGFloat height = width *image.size.height /image.size.width;
//        [image drawInRect:CGRectMake(0, 0, width, height)];
//        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//    }];
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    NSInteger seconds = topic.voicetime / 60;
    NSInteger minutes = topic.voicetime %  60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%zd:%zd",seconds,minutes];
}


@end
