//
//  LTTopicPictureView.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/29.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTTopic;
@interface LTTopicPictureView : UIView
@property (strong,nonatomic) LTTopic *topic;

+ (instancetype)imageView;


@end
