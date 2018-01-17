//
//  LTTopicCell.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/25.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTTopic;
@interface LTTopicCell : UITableViewCell
@property (nonatomic,strong) LTTopic *topic;

+ (instancetype)cell;
@end
