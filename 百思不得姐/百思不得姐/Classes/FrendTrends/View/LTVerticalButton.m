//
//  LTVerticalButton.m
//  百思不得姐
//
//  Created by Sunallies on 2017/12/23.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTVerticalButton.h"

@implementation LTVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        <#statements#>
//    }
//
//
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0 ;
    self.titleLabel.y = self.width;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    LTLog(@"%@,%@",NSStringFromCGRect(self.imageView.frame),NSStringFromCGRect(self.titleLabel.frame));
    
}
@end
