//
//  LTPublishView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/4.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTPublishView.h"
#import "LTVerticalButton.h"
#import <POP.h>
#define LTRootView [UIApplication sharedApplication].keyWindow.rootViewController.view
@implementation LTPublishView

+ (instancetype)publishView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib{
    LTRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    NSArray *image = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *title = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (screenH - 2*buttonW)* 0.5;
    CGFloat buttonStartX = 20;
    CGFloat buttonMarginx = (screenW - 2*buttonStartX - buttonW * maxCols)/(maxCols -1);
    
    for (int i = 0; i< image.count; i ++) {
        LTVerticalButton *btn = [[LTVerticalButton alloc] init];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (buttonW + buttonMarginx);
        CGFloat buttonY = buttonStartY + row * buttonH;
        CGFloat buttonStartY = buttonY - screenH;
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        animation.springSpeed = 10;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + 0.1 * i;
        [btn pop_addAnimation:animation forKey:nil];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:imageView];
    CGFloat centerX = screenW * 0.5;
    CGFloat centerY = screenH * 0.2;
    CGFloat centerBeginY = centerY - screenH;
    imageView.centerX = centerX;
    imageView.centerY = centerBeginY;
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    animation.springSpeed = 10;
    animation.springBounciness = 10;
    animation.beginTime = CACurrentMediaTime() + image.count * 0.1;
    [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        LTRootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
    [imageView pop_addAnimation:animation forKey:nil];
}


- (void)buttonClick:(UIButton *)button{
    [self cancelWithCompletedBlock:^{
        if (button.tag == 0) {
            NSLog(@"发视频");
        }else if (button.tag == 1){
            NSLog(@"发图片");
            
        }
    }];

}
- (IBAction)cancel {
    [self cancelWithCompletedBlock:nil];
    
}

- (void)cancelWithCompletedBlock:(void(^)(void))completedBlock{
    LTRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    NSInteger beginIndex = 1;
    for (int i = 1; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        CGFloat centerY = subView.centerY + screenH;
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + (i - beginIndex)*0.1;
        animation.springSpeed = 10;
        animation.springBounciness = 10;
        [subView pop_addAnimation:animation forKey:nil];
        
        if (i == self.subviews.count -1) {
            [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                LTRootView.userInteractionEnabled = YES;
                [self removeFromSuperview];
                !completedBlock? :completedBlock();
            }];
        }
        
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self cancelWithCompletedBlock:nil];
}

@end
