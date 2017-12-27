//
//  LTRecommendTagViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/23.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTRecommendTagViewController.h"
#import "LTRecommendTagCell.h"
#import "LTTags.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface LTRecommendTagViewController ()
@property (strong,nonatomic) NSArray *tags;
@end

@implementation LTRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setUpTableView{
    self.title = @"推荐关注";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LTGlobalBg;
    
}

- (void)loadData{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"]= @"tag_recommend";
    paras[@"action"]= @"sub";
    paras[@"c"] = @"topic";
    AFHTTPSessionManager *mgr =[AFHTTPSessionManager manager];
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [LTTags mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载图片失败"];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   LTRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tag"];
    cell.tags = self.tags[indexPath.row];
    return cell;
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
