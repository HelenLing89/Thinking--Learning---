//
//  LTTagTextField.h
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/19.
//  Copyright © 2018年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTagTextField : UITextField

@property (nonatomic,copy) void(^deleteBlock)(void);
@end
