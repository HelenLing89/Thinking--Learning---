//
//  LTMeViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTMeViewController.h"
#import "LTMeCell.h"
#import "LTMeFooterView.h"

@interface LTMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = LTGlobalBg;
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(setClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    [self setUpTableView];
}

- (void)setUpTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LTMeCell class] forCellReuseIdentifier:@"me"];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LTTopicCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(LTTopicCellMargin - 35,0, 0, 0);
    //self.tableView.contentSize = CGSizeMake(screenW, screenH);
    self.tableView.tableFooterView = [[LTMeFooterView alloc] init];
    
}

- (void)setClick{
    
    LTLogFunc;
    
}

- (void)moonClick{
    
    LTLogFunc;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    
    }
    
    return cell;
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
