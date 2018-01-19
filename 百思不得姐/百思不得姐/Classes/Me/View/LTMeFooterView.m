//
//  LTMeFooterView.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/17.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTMeFooterView.h"
#import "LTSquare.h"
#import "LTSquareButton.h"
#import "LTWebViewController.h"
#import <MJExtension.h>
#import <AFNetworking.h>
@interface LTMeFooterView()
@property (nonatomic,copy) NSArray *squares;
@end

@implementation LTMeFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"a"] = @"square";
        paras[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [LTSquare mj_objectArrayWithKeyValuesArray:     responseObject[@"square_list"]];
            [self creatSquare:(NSArray *)squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
    
}

    
- (void)creatSquare:(NSArray *)square{
    int maxCols = 4;
    CGFloat squareW = screenW / maxCols;
    CGFloat squareH = squareW;
    
    for (int i = 0; i < square.count; i++) {
        LTSquareButton *button = [LTSquareButton buttonWithType:UIButtonTypeCustom];
        button.square = square[i];
        NSInteger cols = i % maxCols;
        NSInteger row = i / maxCols;
        button.frame = CGRectMake(cols * squareW, row *squareH, squareW, squareH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    NSInteger rows = (square.count + maxCols - 1) /maxCols;
    self.height = rows * squareH;
    [self setNeedsDisplay];
    }

- (void)buttonClick:(LTSquareButton *)button{
    if (![button.square.url hasPrefix:@"http"]) return;
    LTWebViewController *web = [[LTWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    UITabBarController *tab = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = tab.selectedViewController;
    [nav pushViewController:web animated:YES];
}

@end
