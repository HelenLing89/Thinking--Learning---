//
//  UIImageView+LTExtension.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/17.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "UIImageView+LTExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LTExtension)
- (void)setHeader:(NSString *)url{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
    
}
@end
