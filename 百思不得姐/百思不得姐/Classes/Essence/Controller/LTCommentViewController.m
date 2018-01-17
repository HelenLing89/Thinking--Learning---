//
//  LTCommentViewController.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/9.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTCommentViewController.h"
#import "LTComment.h"
#import "LTTopic.h"
#import "LTCommentCell.h"
#import "LTTopicCell.h"
#import "LTCommentHeaderView.h"
#import "LTCommentCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface LTCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSMutableArray *hotcomment;
@property (nonatomic,strong) NSMutableArray *latestComment;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) LTComment *saved_top_cmt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@end

@implementation LTCommentViewController

-(NSMutableArray *)hotcomment{
    if (_hotcomment == nil) {
        _hotcomment = [NSMutableArray array];
    }
    return _hotcomment;
}


-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBasic];
    [self setUpHeader];
    [self setUpFresh];
}

-(void)setUpFresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    //self.tableView.mj_footer.hidden = YES;
}
                                
-(void)loadNewComment{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"dataList";
    paras[@"c"] = @"comment";
    paras[@"hot"] = @"1";
    paras[@"data_id"] = self.topic.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/lingtian/Desktop/comment.plist" atomically:YES];
        self.hotcomment = [LTComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComment = [LTComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showWithStatus:@"加载失败"];
    }];
}


-(void)loadMoreComment{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    NSInteger page = self.page;
    paras[@"a"] = @"dataList";
    paras[@"c"] = @"comment";
    paras[@"hot"] = @(page +1);
    paras[@"data_id"] = self.topic.ID;
    LTComment *comment = [self.latestComment lastObject];
    paras[@"lastcid"] = comment.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        NSArray *newComment = [LTComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComment addObjectsFromArray:newComment];
        self.page = page;
        //NSInteger total = [responseObject[@"total"] integerValue];
        //if (self.latestComment.count >= total) {
          //  self.tableView.mj_footer.hidden = YES;
       // }else{
            [self.tableView.mj_footer endRefreshing];
           [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showWithStatus:@"加载失败"];
    }];
    
}


-(void)setUpBasic{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    //self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTCommentCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    self.tableView.backgroundColor = LTGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.autoresizesSubviews = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,LTTopicCellMargin ,0 );
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTCommentCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)KeyboardWillChangeFrame:(NSNotification*)note{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = screenH - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]  doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
}
-(void)setUpHeader{
    UIView *header = [[UIView alloc] init];
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    //header.backgroundColor = LTGlobalBg;
    LTTopicCell *cell = [LTTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(screenW, self.topic.cellHeight);
    cell.backgroundColor = [UIColor whiteColor];
    header.height = self.topic.cellHeight +LTTopicCellMargin;
    
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

-(NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0){
        return self.hotcomment.count? self.hotcomment : self.latestComment;
    }else{
        return self.latestComment;
    }
}

- (LTComment *)commentsInIndexpath:(NSIndexPath*)indexPath{
//    NSArray *com = [self commentsInSection:indexPath.section];
//    LTComment *comment = comment[indexPath.row];
    return [self commentsInSection:indexPath.section][indexPath.row];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotcount = self.hotcomment.count;
    NSInteger latestcount = self.latestComment.count;
    if (hotcount) return 2;
    if (latestcount) return 1;
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *comment = [self commentsInSection:section];
    return comment.count;
    }

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LTCommentHeaderView *header = [LTCommentHeaderView headerViewWithTableView:tableView];
    NSInteger hotcount = self.hotcomment.count;
    if (section == 0) {
        header.title = hotcount? @"最热评论":@"最新评论";
    }else{
        header.title = @"最新评论";
    }
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    cell.comment = [self commentsInIndexpath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        LTCommentCell *cell = (LTCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *repost = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(repost:)];
        menu.menuItems = @[ding,repost,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
    
    
}

-(void)ding:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LTLog(@"%@",[self commentsInIndexpath:indexPath].content);
}
-(void)report:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LTLog(@"%@",[self commentsInIndexpath:indexPath].content);
}
-(void)repost:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    LTLog(@"%@",[self commentsInIndexpath:indexPath].content);
}
@end
