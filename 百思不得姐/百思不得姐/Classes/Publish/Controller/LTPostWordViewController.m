//
//  LTPostWordViewController.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/18.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTPostWordViewController.h"
#import "LTPlaceholderTextView.h"
#import "LTAddTagToolBar.h"
@interface LTPostWordViewController () <UITextViewDelegate>
@property (nonatomic,strong) LTPlaceholderTextView *textView;
@property (nonatomic,strong) LTAddTagToolBar *toolBar;
@end

@implementation LTPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTextView];
    [self setUpToolBar];
    
}

- (void)UIKeyboardWillChangeFrame:(NSNotification *)note{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, self.view.height - keyboardF.origin.y);
    }];
    
}

- (void)setUpToolBar{
    
    LTAddTagToolBar *toolBar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LTAddTagToolBar class]) owner:nil options:nil] lastObject];
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void)setUpTextView{
    LTPlaceholderTextView *textview = [[LTPlaceholderTextView alloc] init];
    textview.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textview.frame = self.view.bounds;
    [self.view addSubview:textview];
    textview.delegate = self;
    self.textView = textview;
}

- (void)setUpNav{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
    
}


- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)post{
    
    LTLog(@"post");
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
}
@end
