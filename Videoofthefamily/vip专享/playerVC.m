//
//  playerVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "playerVC.h"
#import <WebKit/WebKit.h>

@interface playerVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wk_WebView;
@end

@implementation playerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"513影视";
    
    [self.view addSubview:self.wk_WebView];
    [_wk_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstr]]];

    
    [self.wk_WebView isLoading];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (WKWebView*)wk_WebView {
    if (!_wk_WebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.userContentController = [[WKUserContentController alloc]init];
        _wk_WebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) configuration:config];
        _wk_WebView.navigationDelegate = self;
        _wk_WebView.UIDelegate = self;
        //添加此属性可触发侧滑返回上一网页与下一网页操作
        _wk_WebView.allowsBackForwardNavigationGestures = YES;
    }
    return _wk_WebView;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

- (void)dealloc {
    [_wk_WebView stopLoading];
     _wk_WebView.UIDelegate = nil;
    _wk_WebView.navigationDelegate = nil;

}


@end
