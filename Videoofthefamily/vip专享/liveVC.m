//
//  liveVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "liveVC.h"
#import <WebKit/WebKit.h>

@interface liveVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wk_WebView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@end

@implementation liveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.vname;
    
    [self.view addSubview:self.wk_WebView];
    [_wk_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self createNaviItem];
    
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


#pragma mark 导航按钮
- (void)createNaviItem {
    [self showLeftBarButtonItem];
}

- (void)showLeftBarButtonItem {
    //    if ([_webView canGoBack] || [_wk_WebView canGoBack]) {
    //        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem,self.closeBarButtonItem];
    //    } else {
    //        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    //    }
    
    self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem,self.closeBarButtonItem];
}


- (UIBarButtonItem*)backBarButtonItem {
    if (!_backBarButtonItem) {
        
        
        
        //_backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        _backBarButtonItem.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
        
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem*)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
        _closeBarButtonItem.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _closeBarButtonItem;
}

- (void)back:(UIBarButtonItem*)item {
    if ([_wk_WebView canGoBack]) {
        [_wk_WebView goBack];
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)close:(UIBarButtonItem*)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 自定义导航按钮支持侧滑手势处理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self addNotification];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    if (self.navigationController.viewControllers.count > 1) {
//        self.delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
}

#pragma mark - 控制屏幕旋转方法
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate{
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
