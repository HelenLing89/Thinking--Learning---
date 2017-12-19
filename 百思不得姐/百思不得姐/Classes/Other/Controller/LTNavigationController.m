//
//  LTNavigationController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTNavigationController.h"

@interface LTNavigationController ()

@end

@implementation LTNavigationController

+ (void)initialize {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
          [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);
        //btn.backgroundColor = [UIColor greenColor];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       // [btn sizeToFit];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
    
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
    
}

@end
