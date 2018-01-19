//
//  LTAddTagToolBar.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/18.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTAddTagToolBar.h"
#import "LTAddTageViewController.h"
@interface LTAddTagToolBar()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong) NSMutableArray *tagLabels;
@property (nonatomic,strong) UIButton *addButton;

@end
@implementation LTAddTagToolBar

- (NSMutableArray *)tagLabels{
    if (_tagLabels == nil) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = LTTagMargin;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = addButton;
    [self.topView addSubview:addButton];
    [self createTagLabels:@[@"吐槽",@"糗事"]];
}

- (void)addButtonClick{
    LTAddTageViewController *addTag = [[LTAddTageViewController alloc] init];
    __weak typeof (self) weakSelf = self;
    [addTag setTagsblock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    addTag.tags = [self.tagLabels valueForKey:@"text"];
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
    [nav pushViewController:addTag animated:YES];
}

- (void)createTagLabels:(NSArray *)tags{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self.tagLabels addObject:label];
        label.backgroundColor = LTTagBg;
        label.text = tags[i];
        label.font = LTTagFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        label.width += 2 *LTTagMargin;
        label.height = LTTagH;
        [self.topView addSubview:label];
        
    }
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        if (i == 0) {
            tagLabel.x = LTTagMargin;
            tagLabel.y = 0;
        }else {
            UILabel *lastLabel = self.tagLabels[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + LTTagMargin;
            CGFloat rightWidth = self.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                tagLabel.x = leftWidth;
                tagLabel.y = lastLabel.y;
            }else {
                tagLabel.x = LTTagMargin;
                tagLabel.y = CGRectGetMaxY(lastLabel.frame)+ LTTagMargin;
            }
        }
    }
    
    //更新addButton的frame
    
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + LTTagMargin;
    if (self.width - leftWidth >= self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastLabel.y;
    }else {
        self.addButton.x = LTTagMargin;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame) + LTTagMargin;
        
    }
    
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 60;
    self.y -= self.height - oldH;
    
}


@end
