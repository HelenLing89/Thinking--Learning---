//
//  LTEssenceViewController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTEssenceViewController.h"
#import "LTRecommendTagViewController.h"
#import "LTTopicViewController.h"
@interface LTEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,strong) UIScrollView *contentView;
@end

@implementation LTEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.navigationController.navigationBar.translucent = NO;
    [self setUpNav];
    [self setUpChildVc];
    [self setUpTitleView];
    [self setUpContentView];
    
}


- (void)setUpChildVc{
    LTTopicViewController *vc1 = [[LTTopicViewController alloc] init];
    vc1.title = @"帖子";
    vc1.type = LTTopicTypeWord;
    [self addChildViewController:vc1];
    LTTopicViewController *vc2 = [[LTTopicViewController alloc] init];
    vc2.title = @"全部";
    vc2.type = LTTopicTypeAll;
    [self addChildViewController:vc2];
    LTTopicViewController *vc3 = [[LTTopicViewController alloc] init];
    vc3.title = @"声音";
    vc3.type = LTTopicTypeVoice;
    [self addChildViewController:vc3];
    LTTopicViewController *vc4 = [[LTTopicViewController alloc] init];
    vc4.title = @"视频";
    vc4.type = LTTopicTypeVideo;
    [self addChildViewController:vc4];
    LTTopicViewController *vc5 = [[LTTopicViewController alloc] init];
    vc5.title = @"图片";
    vc5.type = LTTopicTypePicture;
    [self addChildViewController:vc5];
    
}
- (void)setUpTitleView{
    //添加titleView
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.x = 0;
    titleView.y = 64;
    titleView.height = 35;
    titleView.width = self.view.width;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //设置指示标
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titleView.height - indicator.height;
    self.indicatorView = indicator;
    
    
    
    //设置按钮
    CGFloat width = titleView.width / self.childViewControllers.count;
    NSLog(@"%f,%zd",titleView.width,self.childViewControllers.count);
    CGFloat height = titleView.height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.frame = CGRectMake(i *width, 0,width,height);
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        [button.titleLabel sizeToFit];
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];
            indicator.width = button.titleLabel.width;
            indicator.centerX = button.centerX;
        }
       
    }
    
    [titleView addSubview:indicator];
}

- (void)buttonClick:(UIButton *)button{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    self.indicatorView.width = button.titleLabel.width;
    self.indicatorView.centerX = button.centerX;

    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.view.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setUpContentView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(self.view.width *self.childViewControllers.count, self.view.height);
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    [self.view insertSubview:contentView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:contentView];

}


- (void)setUpNav{
    self.view.backgroundColor = LTGlobalBg;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(btnClick)];
    
    
}
- (void)btnClick{
    LTRecommendTagViewController *vc = [[LTRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger  i = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *vc = self.childViewControllers[i];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
@end
