//
//  LTTopicPictureView.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/29.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopicPictureView.h"
#import "LTTopic.h"
#import "LTProgressView.h"
#import "LTShowPictureViewController.h"
#import <UIImageView+WebCache.h>

@interface LTTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigView;
@property (weak, nonatomic) IBOutlet LTProgressView *progressView;

@end
@implementation LTTopicPictureView
+ (instancetype)imageView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}
- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    //LTLog(@"%@",NSStringFromCGRect(self.progressView.frame));
    self.pictureView.userInteractionEnabled = YES;
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture{
    LTShowPictureViewController *vc = [[LTShowPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}
- (void)setTopic:(LTTopic *)topic{
    _topic = topic;
    [self.progressView setProgress:topic.progress animated:NO];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.progressView.hidden = NO;
        });
        
            //self.progressView.frame = CGRectMake(100, 100, 100, 100);
    
        topic.progress = 1.0 * receivedSize / expectedSize;
        
        [self.progressView setProgress:topic.progress animated:NO];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
        if (topic.isBigPicture == NO) return;
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size,YES, 0.0);
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width *image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //[self layoutIfNeeded];
        }];
    
     NSString *extension = topic.largeImage.pathExtension;
     self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
     if (topic.isBigPicture) {
        self.seeBigView.hidden = NO;
        //self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
     }else{
        self.seeBigView.hidden = YES;
        //self.pictureView.contentMode = UIViewContentModeScaleAspectFit;
    }

}
    





@end
