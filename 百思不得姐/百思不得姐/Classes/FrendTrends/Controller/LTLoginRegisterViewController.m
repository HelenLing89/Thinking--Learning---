//
//  LTLoginRegisterViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/21.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTLoginRegisterViewController.h"

@interface LTLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLoginConstraint;

@end

@implementation LTLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
//当statusBar不由控制器控制时,基于application,使用这个方法
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)loginOrRegisterButtonClick:(UIButton *)sender {
    [self.view endEditing:YES]
    ;    if (self.leftLoginConstraint.constant == 0) {
        self.leftLoginConstraint.constant = - self.view.width;
        sender.selected = YES;
    }else {
        self.leftLoginConstraint.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:2.0 animations:^{
          [self.view layoutIfNeeded];
    }];
  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// statusBar由控制器管理的时候, 用这个方法
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
@end
