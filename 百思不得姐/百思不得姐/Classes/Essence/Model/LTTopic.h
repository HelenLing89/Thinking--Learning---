//
//  LTTopic.h
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/26.
//  Copyright © 2017年 helen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTComment;
@interface LTTopic : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *profile_image;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;;
@property (nonatomic,assign,getter=isSinaV) BOOL sinaV;
@property (nonatomic,assign) LTTopicType type;
@property (nonatomic,copy) NSString *smallImage;
@property (nonatomic,copy) NSString *middleImage;
@property (nonatomic,copy) NSString *largeImage;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,assign) NSInteger playcount;
@property (nonatomic,assign) NSInteger videotime;
@property (nonatomic,copy) LTComment *top_cmt;

/*辅助属性*/
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGRect pictureF;
@property (nonatomic,assign) CGRect voiceF;
@property (nonatomic,assign) CGRect videoF;
@property (nonatomic,assign,getter=isBigPicture) BOOL bigPicture;
@property (nonatomic,assign) CGFloat progress;

@end
