//
//  NSDate+LTExtension.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/27.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "NSDate+LTExtension.h"

@implementation NSDate (LTExtension)

- (NSDateComponents *)delatformDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:date toDate:self options:0];
    
}

- (BOOL)isThisYear {
   NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}


- (BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}
@end
