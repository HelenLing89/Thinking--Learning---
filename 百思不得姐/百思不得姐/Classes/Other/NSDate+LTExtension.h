//
//  NSDate+LTExtension.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/27.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTExtension)
- (NSDateComponents *)delatformDate:(NSDate *)date;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
@end
