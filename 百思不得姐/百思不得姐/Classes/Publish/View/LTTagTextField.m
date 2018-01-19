//
//  LTTagTextField.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/19.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTTagTextField.h"

@implementation LTTagTextField
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = LTTagH;
    }
return self;
    
}

- (void)deleteBackward{
    
    !self.deleteBlock ? :  self.deleteBlock();
    [super deleteBackward];
    
}

@end
