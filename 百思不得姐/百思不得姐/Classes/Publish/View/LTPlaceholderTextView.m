//
//  LTPlaceholderTextView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/18.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTPlaceholderTextView.h"

@interface LTPlaceholderTextView()
@property (nonatomic,strong) UILabel *placeholderLabel;

@end

@implementation LTPlaceholderTextView


- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.x = 4;
        _placeholderLabel.y = 7;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholdercolor = [UIColor grayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    
    return self;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange{
    
    self.placeholderLabel.hidden = self.hasText;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    
}

- (void)setPlaceholdercolor:(UIColor *)placeholdercolor{
    _placeholdercolor = placeholdercolor;
    self.placeholderLabel.textColor = placeholdercolor;
    [self setNeedsLayout];
}


- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsLayout];
}


- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsLayout];
}
@end
