//
//  LTWebViewController.m
//  百思不得姐
//
//  Created by 凌甜 on 2018/1/17.
//  Copyright © 2018年 helen. All rights reserved.
//

#import "LTWebViewController.h"
#import "LTSquare.h"
#import <NJKWebViewProgress.h>

@interface LTWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (nonatomic,strong) NJKWebViewProgress *progress;

@end

@implementation LTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof (self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 0.0);
        
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackItem.enabled = self.webView.canGoBack;
    self.goForwardItem.enabled = self.webView.canGoForward;
}


- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
    
}

- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)fresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}



@end
