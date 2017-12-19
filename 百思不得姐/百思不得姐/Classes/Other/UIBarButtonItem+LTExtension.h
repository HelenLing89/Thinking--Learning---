//
//  UIBarButtonItem+LTExtension.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/19.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LTExtension)

+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString*)highImage target:(id)target action:(SEL)action;

@end
