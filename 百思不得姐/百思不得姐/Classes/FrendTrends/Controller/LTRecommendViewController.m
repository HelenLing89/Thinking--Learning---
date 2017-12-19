//
//  LTRecommendViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/19.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface LTRecommendViewController ()

@end

@implementation LTRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.view.backgroundColor = LTGlobalBg;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"category";
    para[@"c"] = @"subscribe";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];
    
    
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
