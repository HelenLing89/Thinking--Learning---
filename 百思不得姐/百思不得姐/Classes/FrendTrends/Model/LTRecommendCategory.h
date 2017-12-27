//
//  LTRecommendCategory.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/20.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTRecommentUser.h"

@interface LTRecommendCategory : NSObject
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSMutableArray *users;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,assign) NSInteger currentPage;
@end
