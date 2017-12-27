//
//  LTRecommendCategory.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/20.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendCategory.h"

@implementation LTRecommendCategory
- (NSMutableArray *)users{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}
@end
