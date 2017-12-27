//
//  LTRecommendViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/19.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendViewController.h"
#import "LTRecommendModel.h"
#import "LTRecommendCategory.h"
#import "LTRecommendCategoryCell.h"
#import "LTRecommentUserCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#define LTSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface LTRecommendViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic,strong) NSArray *categories;
@property (nonatomic,strong) NSMutableDictionary *para;
@end

@implementation LTRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    self.view.backgroundColor = LTGlobalBg;
    [self setUpTableView];
    [self loadCategory];
    [self setUpFresh];

}

- (void)setUpTableView{
   self.categoryTableView.backgroundColor = [UIColor clearColor];
   [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
   [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTRecommentUserCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
   
//    self.categoryTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    self.userTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.userTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.userTableView.rowHeight = 70;
    
    
}
- (void)loadCategory{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"category";
    para[@"c"] = @"subscribe";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        LTRecommendModel * recommendModel = [LTRecommendModel mj_objectWithKeyValues:responseObject];
        
        self.categories = [LTRecommendCategory mj_objectArrayWithKeyValuesArray:recommendModel.list];
        [self.categoryTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
    }];
    
}

- (void)setUpFresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
    
    
}
- (void)loadUsers{
    LTRecommendCategory *rc = LTSelectedCategory;
    rc.currentPage = 1;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(rc.id);
    para[@"page"] = @(rc.currentPage);
    self.para = para;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *user = [LTRecommentUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users removeAllObjects];
        [rc.users addObjectsFromArray:user];
        rc.total = [responseObject[@"total"] integerValue];
        if (self.para != para) return;
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.para != para) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
    
}

- (void)loadMoreUsers{
    LTRecommendCategory *rc = LTSelectedCategory;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(rc.id);
    para[@"page"] = @(++rc.currentPage);
    self.para = para;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *user = [LTRecommentUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users addObjectsFromArray:user];
        rc.total = [responseObject[@"total"] integerValue];
        if (self.para != para) return;
        [self.userTableView reloadData];
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.para != para) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        [self.userTableView.mj_footer endRefreshing];
    }];
    
    
}

- (void)checkFooterStatus{
    LTRecommendCategory *rc = LTSelectedCategory;
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
        
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView ) {
        return self.categories.count;
    }else {
        NSLog(@"%zd",[LTSelectedCategory users].count);
        return [LTSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        LTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category"];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        LTRecommentUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
        LTRecommendCategory *rc = LTSelectedCategory;
        cell.user = rc.users[indexPath.row];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.userTableView.mj_header endRefreshing];
    //[self.userTableView.mj_footer endRefreshing];
    
    LTRecommendCategory *rc = self.categories[indexPath.row];
    if (rc.users.count) {
        [self.userTableView reloadData];
    }else {
        [self.userTableView reloadData];
        [self.userTableView.mj_header beginRefreshing];
        
    }
}

@end
