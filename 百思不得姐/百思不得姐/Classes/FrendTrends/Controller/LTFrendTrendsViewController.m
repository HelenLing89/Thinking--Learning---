//
//  LTFrendTrendsViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTFrendTrendsViewController.h"
#import "LTRecommendViewController.h"

@interface LTFrendTrendsViewController ()

@end

@implementation LTFrendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LTGlobalBg;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(frendClick)];
    
}

- (void)frendClick{
    LTRecommendViewController *vc = [[LTRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
