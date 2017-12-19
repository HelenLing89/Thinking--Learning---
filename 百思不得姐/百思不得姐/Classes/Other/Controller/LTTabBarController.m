//
//  LTTabBarController.m
//  百思不得姐
//
//  Created by KevinMitnick on 2017/12/18.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTabBarController.h"
#import "LTEssenceViewController.h"
#import "LTNavigationController.h"
#import "LTNewViewController.h"
#import "LTFrendTrendsViewController.h"
#import "LTMeViewController.h"
#import "LTTabBar.h"
@implementation LTTabBarController
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    LTEssenceViewController *essenceVc = [[LTEssenceViewController alloc] init];
    //self.tabBarItem.title = @"精华";
    [self setUp:essenceVc image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    LTNewViewController *newVc = [[LTNewViewController alloc] init];
    [self setUp:newVc image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    LTFrendTrendsViewController *frendTrendsVc = [[LTFrendTrendsViewController alloc] init];
    [self setUp:frendTrendsVc image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    LTMeViewController *meVc = [[LTMeViewController alloc] init];
    [self setUp:meVc image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
    
    [self setValue:[[LTTabBar alloc] init] forKey:@"tabBar"];
    
    
    
    
    
}


- (void)setUp:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    LTNavigationController *naVc = [[LTNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:naVc];
    
    
}

@end
