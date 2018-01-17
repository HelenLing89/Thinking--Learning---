//
//  LTCommentHeaderView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/10.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTCommentHeaderView.h"
@interface LTCommentHeaderView()
@property (nonatomic,strong) UILabel *label;
@end
@implementation LTCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    LTCommentHeaderView * header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:@"header"];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LTGlobalBg;
        UILabel *label = [[UILabel alloc] init];
        //label.backgroundColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:0.5];
        label.x = LTTopicCellMargin;
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
    
}

@end
