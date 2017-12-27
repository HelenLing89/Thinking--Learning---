//
//  LTTopic.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/26.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTTopic : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *profile_image;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,assign,getter=isSinaV) BOOL sinaV;
@property (nonatomic,assign) LTTopicType type;

@end
