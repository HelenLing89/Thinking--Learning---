//
//  LTRecommendCategoryCell.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/20.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendCategoryCell.h"
#import "LTRecommendCategory.h"
@interface LTRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end
@implementation LTRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
   self.backgroundColor = LTRGBColor(244, 244, 244);
    self.selectedView.backgroundColor = LTRGBColor(219,21,26);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
    
    
}
- (void)setCategory:(LTRecommendCategory*)category{
    _category = category;
    self.textLabel.text = category.name;
    }
                                         
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedView.hidden = !selected;
    self.textLabel.textColor = selected? self.selectedView.backgroundColor : LTRGBColor(78, 78, 78);
    
}

@end
