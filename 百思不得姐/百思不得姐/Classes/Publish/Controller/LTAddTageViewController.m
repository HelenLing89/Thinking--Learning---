//
//  LTAddTageViewController.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/18.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTAddTageViewController.h"
#import "LTTagTextField.h"
#import "LTTagButton.h"
#import <SVProgressHUD.h>

@interface LTAddTageViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) LTTagTextField *textField;
@property (nonatomic,strong) NSMutableArray *tagButtons;
@property (nonatomic,strong) UIButton *addButton;
//@property (nonatomic,strong) LTTagButton *tagButton;

@end

@implementation LTAddTageViewController

#pragma mark-懒加载

- (NSMutableArray *)tagButtons {
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
        
    }
    return _tagButtons;
    
}

- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = LTTagBg;
        _addButton.height = LTTagH;
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = LTTagFont;
        _addButton.contentEdgeInsets = UIEdgeInsetsMake(0, LTTagMargin,LTTagMargin, 0);
        //文字图片都左靠齐
        _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (LTTagTextField *)textField{
    if (_textField == nil) {
        __weak typeof(self) weakSelf = self;
        _textField = [[LTTagTextField alloc] init];
        _textField.deleteBlock = ^(){
        if (weakSelf.textField.hasText) return;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}


- (void)textDidChange{
    [self updateTextFieldFrame];
    
    if ([self.textField hasText]) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + LTTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        NSString *text = self.textField.text;
        NSInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","] ||[lastLetter isEqualToString:@"，"]) {
            self.textField.text = [text substringToIndex:len - 1];
            [self addButtonClick];
        }
    }else {
        self.addButton.hidden = YES;
    }
 }

- (void)tagButtonClick:(LTTagButton *)tagButton{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
    
    
}

- (void)addButtonClick{
    if (self.tagButtons.count == 5) {
        
       // SVProgressHUD *hud = [[SVProgressHUD alloc] init];
      //  [SVProgressHUD showWithStatus:@"最多显示5个标签" maskType:SVProgressHUDMaskTypeBlack];
       [SVProgressHUD showWithStatus:@"最多显示5个标签"];
       [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD dismissWithDelay:2.0];
    
        return;
    }
    LTTagButton *tagButton = [LTTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    self.textField.text = nil;
    self.addButton.hidden = YES;
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
}

- (void)setUpNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
}

- (void)cancel{


    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)done{
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    
    !self.tagsblock? :self.tagsblock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews{
    self.contentView.x = LTTagMargin;
    self.contentView.y = 64 + LTTagMargin;
    self.contentView.width = self.view.width - 2 *LTTagMargin;
    self.contentView.height = self.view.height;
    self.addButton.width = self.contentView.width;
    self.textField.width = self.contentView.width;
    
    
    [self setUpTags];
}


- (void)setUpTags{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addButtonClick];
        }
        self.tags = nil;
    }
}

- (void)updateTagButtonFrame{
    for (int i = 0; i < self.tagButtons.count; i++) {
        LTTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {
            tagButton.x = 0;
            tagButton.y = 0;
        }else {
            LTTagButton *lastButton = self.tagButtons[i-1];
            CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + LTTagMargin;
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastButton.y;
            }else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastButton.frame) + LTTagMargin;
            }
        }
    }
}


- (void)updateTextFieldFrame{
    LTTagButton *tagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(tagButton.frame) + LTTagMargin;
    if (self.contentView.width - leftWidth >= [self textFieldWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = tagButton.y;
    }else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(tagButton.frame);
    }
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + LTTagMargin;
}

- (CGFloat)textFieldWidth{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.textField hasText]) {
        [self addButtonClick];
    }
    return YES;
}

@end
