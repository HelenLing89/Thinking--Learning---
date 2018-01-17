//
//  LTShowPictureViewController.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/3.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTShowPictureViewController.h"
#import "LTProgressView.h"
#import "LTTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface LTShowPictureViewController ()
@property (weak, nonatomic) IBOutlet LTProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation LTShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height /self.topic.width;
    if(pictureH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(screenW,pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    
    [self.progressView setProgress:self.topic.progress animated:YES];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
    }];
    
    
}



- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"下载图片失败"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
