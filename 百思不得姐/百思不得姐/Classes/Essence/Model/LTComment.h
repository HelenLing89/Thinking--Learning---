//
//  LTComment.h
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/9.
//  Copyright © 2018年 helen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LTUser;
@interface LTComment : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,strong) NSString *voiceuri;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,assign) NSInteger like_count;
@property (nonatomic,strong) LTUser *user;

@end
