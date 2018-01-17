//
//  LTProgressView.m
//  百思不得姐
//
//  Created by KevinMitnick on 2018/1/2.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTProgressView.h"

@implementation LTProgressView

- (void)awakeFromNib{

    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.f%%",progress*100];
    LTLog(@"%@",text);
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}


@end
