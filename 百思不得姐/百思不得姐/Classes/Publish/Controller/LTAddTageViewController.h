//
//  LTAddTageViewController.h
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/18.
//  Copyright © 2018年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTAddTageViewController : UIViewController
@property (nonatomic,strong) void (^tagsblock)(NSArray *tags);
@property (nonatomic,strong) NSArray *tags;

@end
