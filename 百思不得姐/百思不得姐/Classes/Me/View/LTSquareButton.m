//
//  LTSquareButton.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/17.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTSquareButton.h"
#import "LTSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>

@implementation LTSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.height * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setSquare:(LTSquare *)square{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}

@end
