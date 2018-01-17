//
//  LTComment.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/9.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTComment.h"
#import <MJExtension.h>
@implementation LTComment
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" :@"id"};
    
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"user" : @"LTUser"
             };
}


@end
