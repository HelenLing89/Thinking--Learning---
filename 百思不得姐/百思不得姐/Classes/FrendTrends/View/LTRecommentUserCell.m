//
//  LTRecommentUserCell.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/21.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommentUserCell.h"
#import "LTRecommentUser.h"
#import <UIImageView+WebCache.h>

@interface LTRecommentUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screen_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fans_countLabel;

@end
@implementation LTRecommentUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(LTRecommentUser *)user{
    _user = user;
    self.screen_nameLabel.text = user.screen_name;
    self.fans_countLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
