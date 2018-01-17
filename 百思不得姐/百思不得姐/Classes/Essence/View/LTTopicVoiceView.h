//
//  LTTopicVoiceView.h
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/5.
//  Copyright © 2018年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTTopic;

@interface LTTopicVoiceView : UIView

@property (nonatomic,strong) LTTopic *topic;
+ (instancetype)voiceView;
@end
