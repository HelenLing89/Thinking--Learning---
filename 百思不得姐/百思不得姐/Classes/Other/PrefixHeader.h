//
//  PrefixHeader.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h
#import "UIView+LTExtension.h"
#import "UIBarButtonItem+LTExtension.h"
#import "NSDate+LTExtension.h"
#import "LTConst.h"
#import "UIImage+LTExtension.h"
#import "UIImageView+LTExtension.h"
#ifdef DEBUG
#define LTLog(...) NSLog(__VA_ARGS__)
#else
#define LTLog(...)
#endif

#define LTLogFunc LTLog(@"%s",__func__)

#define LTRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LTGlobalBg LTRGBColor(223,223,223)
#define screenW [UIApplication sharedApplication].keyWindow.bounds.size.width
#define screenH [UIApplication sharedApplication].keyWindow.bounds.size.height
#define LTTagBg LTRGBColor(74, 139, 209)
#define LTTagFont [UIFont systemFontOfSize:14]

#endif 
