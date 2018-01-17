//
//  LTTopWindow.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/11.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTTopWindow.h"
@interface LTTopWindow()
@property (nonatomic,strong) UIWindow *window;
@end
@implementation LTTopWindow

static UIWindow *window_;

+ (void)initialize{
    window_ = [[UIWindow alloc] init];
    window_.frame =CGRectMake(0, 0, screenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
}
     
+(void)show{
    window_.hidden = NO;
}

+ (void)windowClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

     
+ (void)searchScrollViewInView:(UIView*)superView{
    for(UIScrollView *scrollView in superView.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]] && [scrollView isShowingOnKeyWindow]){
            CGPoint offset = scrollView.contentOffset;
            offset.y = - scrollView.contentInset.top;
            [scrollView setContentOffset:offset animated:YES];
            
        }
        [self searchScrollViewInView:scrollView];
    }
}
@end
