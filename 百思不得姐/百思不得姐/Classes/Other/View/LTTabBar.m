//
//  LTTabBar.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTabBar.h"
#import "LTPublishView.h"
@interface LTTabBar()
@property (nonatomic,strong) UIButton *publishBtn;
@end
@implementation LTTabBar

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishBtn.size = publishBtn.currentBackgroundImage.size;
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
}
    return self;
}

- (void)publishClick{
    LTPublishView *publish = [LTPublishView publishView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    publish.frame = window.frame;
    [window addSubview:publish];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonX = 0;
    //CGFloat buttonY = 0;
    CGFloat buttonWidth = width / 5;
    NSInteger i = 0;
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:[UIControl class]] || btn == self.publishBtn) continue;
        buttonX = buttonWidth *((i > 1)? (i + 1) : i) ;
        btn.frame = CGRectMake(buttonX,0, buttonWidth, height);
        i++;
        
    }

}
@end
