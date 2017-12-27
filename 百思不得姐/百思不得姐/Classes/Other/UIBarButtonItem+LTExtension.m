//
//  UIBarButtonItem+LTExtension.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/19.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "UIBarButtonItem+LTExtension.h"

@implementation UIBarButtonItem (LTExtension)
+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString*)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[self alloc] initWithCustomView:button];
}
@end
