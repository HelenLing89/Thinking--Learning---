//
//  LTTopic.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/26.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopic.h"
#import "LTComment.h"
#import "LTUser.h"
#import <MJExtension.h>
@implementation LTTopic

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
      @"smallImage":@"image0",
      @"middleImage":@"image1",
      @"largeImage":@"image2",
      @"ID":@"id",
      @"top_cmt":@"top_cmt[0]"
      };
    
}

- (NSString *)create_time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *comps = [[NSDate date] delatformDate:create];
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute>=1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else {
                return @"刚刚";
            }
        }else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{
        return _create_time;
    }
    
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize MaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*LTTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = LTTopicCellTextY + textH + LTTopicCellMargin;
  
    if (self.type == LTTopicTypePicture) {
        CGFloat pictureW = MaxSize.width;
        CGFloat pictureH = pictureW * self.height / self.width;
        if (pictureH > LTTopicCellPictureMaxH) {
            pictureH = LTTopicCellPictureBreakH;
            self.bigPicture = YES;
        }
        
        CGFloat pictureX = LTTopicCellMargin;
        CGFloat pictureY = LTTopicCellTextY +textH + LTTopicCellMargin;
        _pictureF = CGRectMake(pictureX,pictureY, pictureW, pictureH);
        _cellHeight += pictureH + LTTopicCellMargin;
    }else if (self.type == LTTopicTypeVoice){
        CGFloat voiceW = MaxSize.width;
        CGFloat voiceH = voiceW * self.height /self.width;
        CGFloat voiceX = LTTopicCellMargin;
        CGFloat voiceY = LTTopicCellTextY + textH +LTTopicCellMargin;
        _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        _cellHeight += voiceH + LTTopicCellMargin;
    }else if(self.type == LTTopicTypeVideo){
        CGFloat videoW = MaxSize.width;
        CGFloat videoH = videoW *self.height /self.width;
        CGFloat videoX = LTTopicCellMargin;
        CGFloat videoY = LTTopicCellTextY + textH + LTTopicCellMargin;
        _videoF = CGRectMake(videoX, videoY, videoW, videoH);
        _cellHeight += videoH + LTTopicCellMargin;
    }
        
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@:%@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += contentH +LTTopicCellMargin;
    }
        _cellHeight += LTTopicCellBottonBarH + LTTopicCellMargin;
        
    }
   return _cellHeight;
}

@end
