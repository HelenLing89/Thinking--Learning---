//
//  LTTopicViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/25.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTopicViewController.h"
#import "LTTopic.h"
#import "LTTopicCell.h"
#import "LTCommentViewController.h"
#import "LTNewViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
@interface LTTopicViewController ()<UITableViewDataSource,UITabBarDelegate>
@property (nonatomic,strong) NSMutableArray *topics;
@property (nonatomic,strong) AFHTTPSessionManager *mgr;
@property (nonatomic,strong) NSDictionary *paras;
@property (nonatomic,strong) NSString *maxtime;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger lastSelectedIndex;
@end

@implementation LTTopicViewController

- (NSMutableArray *)topics {
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}

- (AFHTTPSessionManager *)mgr {
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpFresh];
}

- (void)setUpTableView{
    CGFloat top = LTTitleViewH + LTTitleViewY;
    CGFloat botton = self.tabBarController.tabBar.height;
    LTLog(@"%f",top);
    //self.tableView.insetsContentViewsToSafeArea = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, botton, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
   // self.navigationController.navigationBar.translucent = NO;

  
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTTopicCell class]) bundle:nil] forCellReuseIdentifier:@"topic"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonClick) name:LTTabBarDidSelectedNotification object:nil];
}


- (void)buttonClick{
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && [self.view isShowingOnKeyWindow]) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
}

- (void)setUpFresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (NSString *)a{
    return [self.parentViewController isKindOfClass:[LTNewViewController class]] ? @"newlist" :@"list";
}

- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = self.a;
    paras[@"c"] = @"data";
    paras[@"type"] = @(self.type);
    self.paras = paras;
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //LTLog(@"%@",self.maxtime);
        //[self.topics removeAllObjects];
        self.topics = [LTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [responseObject writeToFile:@"/Users/lingtian/Desktop/list.plist" atomically:YES];
        if (self.paras != paras) return;
        self.page = 0;
        [self.tableView reloadData];
       // [self.tableView layoutIfNeeded];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.paras != paras) return;
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
    
}


- (void)loadMoreTopics{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = self.a;
    paras[@"c"] = @"data";
    NSInteger page = self.page +1 ;
    paras[@"page"] = @(page);
    paras[@"maxtime"] = self.maxtime;
    paras[@"type"] = @(self.type);
    self.paras = paras;
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topic = [LTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [responseObject writeToFile:@"/Users/lingtian/Desktop/list.plist" atomically:YES];
        [self.topics addObjectsFromArray:topic];
         if (self.paras != paras) return;
        self.page = page;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.paras != self.paras) return;
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];
    
    
    
    
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topic"];
    cell.topic = self.topics[indexPath.row];
    //[self.tableView reloadData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTTopic *topic = self.topics[indexPath.row];
   // [self.tableView reloadData];
    return topic.cellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LTCommentViewController *vc = [[LTCommentViewController alloc] init];
    vc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
