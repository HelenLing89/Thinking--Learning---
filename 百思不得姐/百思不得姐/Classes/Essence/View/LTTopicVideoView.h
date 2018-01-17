//
//  LTTopicVideoView.h
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/8.
//  Copyright © 2018年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTTopic.h"

@interface LTTopicVideoView : UIView

@property (strong,nonatomic) LTTopic *topic;
+ (instancetype)videoView;
@end
