//
//  UIImage+LTExtension.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/17.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "UIImage+LTExtension.h"

@implementation UIImage (LTExtension)
- (UIImage *)circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
