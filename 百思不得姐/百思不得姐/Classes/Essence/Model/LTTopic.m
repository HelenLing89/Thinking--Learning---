//
//  LTTopic.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/26.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopic.h"

@implementation LTTopic

- (NSString *)create_time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *comps = [[NSDate date] delatformDate:create];
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute>=1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else {
                return @"刚刚";
            }
        }else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{
        return _create_time;
    }
    
}

@end
