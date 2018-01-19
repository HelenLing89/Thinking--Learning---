//
//  LTTagButton.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/19.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTTagButton.h"

@implementation LTTagButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backgroundColor = LTTagBg;
        self.titleLabel.font = LTTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * LTTagMargin;
    self.height = LTTagH;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = LTTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LTTagMargin;
}
@end
