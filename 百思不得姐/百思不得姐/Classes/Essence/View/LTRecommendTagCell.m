//
//  LTRecommendTagCell.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/23.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendTagCell.h"
#import "LTTags.h"
#import  <UIImageView+WebCache.h>
@interface LTRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image_listImageView;
@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sub_numberLabel;

@end

@implementation LTRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTags:(LTTags *)tags{
   
    _tags =tags;
    [self.image_listImageView sd_setImageWithURL:[NSURL URLWithString:tags.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_nameLabel.text = tags.theme_name;
    NSString *subnumber = nil;
    if (tags.sub_number > 10000) {
        subnumber = [NSString stringWithFormat:@"%.1f万人关注",tags.sub_number /10000.0];
    }else{
        
        subnumber = [NSString stringWithFormat:@"%zd人关注",tags.sub_number];
    }
    self.sub_numberLabel.text = subnumber;
    
    }
    

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
