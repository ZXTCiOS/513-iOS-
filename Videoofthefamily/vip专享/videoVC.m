//
//  videoVC.m
//  Videoofthefamily
//
//  Created by 王俊钢 on 2017/9/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "videoVC.h"
#import "PopoverAction.h"
#import "PopoverView.h"
#import <WebKit/WebKit.h>
#import "playerVC.h"
#import "JGPopView.h"
#import "urlModel.h"
#import "homeModel.h"
#import "liveVC.h"


static CGFloat const NAVI_HEIGHT = 0;

@interface videoVC ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate,selectIndexPathDelegate>
@property (nonatomic, strong) WKWebView *wk_WebView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) id <UIGestureRecognizerDelegate>delegate;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIProgressView *loadingProgressView;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) NSString *weburl;

@property (nonatomic, strong) NSMutableArray *btnarr0;
@property (nonatomic, strong) NSMutableArray *btnarr1;

@property (nonatomic, strong) NSString *btntypestr;

@property (nonatomic, strong) NSString *typestr;

@end

@implementation videoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.vname;
    
    
    UIBarButtonItem *rightbtn0 = [[UIBarButtonItem alloc] initWithTitle:@"vip" style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn0click)];
    UIBarButtonItem *rightbtn1 = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(rightbtn1click)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightbtn0,rightbtn1,nil]];
    [rightbtn0 setTintColor:[UIColor colorWithHexString:@"FFFFFF"]];
    [rightbtn1 setTintColor:[UIColor colorWithHexString:@"FFFFFF"]];
    
    [self createWebView];
    [self createNaviItem];
    [self loadRequest];
    
    [self datafrom];

}

-(void)datafrom
{
    
    self.btnarr0 = [NSMutableArray array];
    self.btnarr1 = [NSMutableArray array];

    for (int i = 0; i<self.urlarray.count; i++) {
        urlModel *model   = [self.urlarray objectAtIndex:i];
        NSString *url = model.iname;
        [self.btnarr0 addObject:url];
    }
    for (int i = 0; i<self.viparray.count; i++) {
        homeModel *model = [self.viparray objectAtIndex:i];
        NSString *name = model.vname;
        [self.btnarr1 addObject:name];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightbtn0click
{
    //vip
    JGPopView *view2 = [[JGPopView alloc] initWithOrigin:CGPointMake([UIScreen mainScreen].bounds.size.width-40, 60) Width:100 Height:180 Type:JGTypeOfUpCenter Color:[UIColor whiteColor]];
    view2.dataArray = self.btnarr0;
    view2.fontSize = 11;
    view2.row_height = 40;
    view2.titleTextColor = [UIColor blackColor];
    view2.delegate = self;
    [view2 popView];
    self.btntypestr = @"1";
}

-(void)rightbtn1click
{
    //线路切换
    JGPopView *view2 = [[JGPopView alloc] initWithOrigin:CGPointMake([UIScreen mainScreen].bounds.size.width-70, 60) Width:100 Height:180 Type:JGTypeOfUpCenter Color:[UIColor whiteColor]];
    view2.dataArray = self.btnarr1;
    view2.fontSize = 11;
    view2.row_height = 40;
    view2.titleTextColor = [UIColor blackColor];
    view2.delegate = self;
    [view2 popView];
    self.btntypestr = @"2";
}

- (void)selectIndexPathRow:(NSInteger)index{
    if ([self.btntypestr isEqualToString:@"1"]) {
        //vip观看
        playerVC *vc = [[playerVC alloc] init];
        urlModel *model = self.urlarray[index];
        NSString *str1 = model.iurl;
        NSString *str = [NSString stringWithFormat:@"%@%@",str1,self.weburl];
        vc.urlstr = str;
        [self.navigationController pushViewController:vc animated:YES];

    }
    if ([self.btntypestr isEqualToString:@"2"]) {
        //频道切换
        homeModel *model = self.viparray[index];
        NSString *newurl = model.vurl;
        NSString *name = model.vname;
        self.typestr = name;
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
            [_wk_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newurl]]];
        } else {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newurl]]];
        }
    }
    
}

#pragma mark 版本适配
- (void)createWebView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.reloadButton];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [self.view addSubview:self.wk_WebView];
        [self.view addSubview:self.loadingProgressView];
    } else {
        [self.view addSubview:self.webView];
    }
}

- (UIWebView*)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64)];
        _webView.delegate = self;
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 && _canDownRefresh) {
            _webView.scrollView.refreshControl = self.refreshControl;
        }
    }
    return _webView;
}

- (WKWebView*)wk_WebView {
    if (!_wk_WebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.mediaPlaybackRequiresUserAction = YES;
        config.allowsInlineMediaPlayback = NO;
        config.userContentController = [[WKUserContentController alloc]init];
        _wk_WebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) configuration:config];
        _wk_WebView.navigationDelegate = self;
        _wk_WebView.UIDelegate = self;
        //添加此属性可触发侧滑返回上一网页与下一网页操作
        _wk_WebView.allowsBackForwardNavigationGestures = YES;
        //下拉刷新
        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 && _canDownRefresh) {
            _wk_WebView.scrollView.refreshControl = self.refreshControl;
        }
        //进度监听
        [_wk_WebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        

        
    }
    return _wk_WebView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _loadingProgressView.progress = [change[@"new"] floatValue];
        if (_loadingProgressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _loadingProgressView.hidden = YES;
            });
        }
    }
    
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.wk_WebView)
        {
            self.title = self.wk_WebView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

- (void)dealloc {
    [_wk_WebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wk_WebView removeObserver:self forKeyPath:@"title"];
    [_wk_WebView stopLoading];
    [_webView stopLoading];
    _wk_WebView.UIDelegate = nil;
    _wk_WebView.navigationDelegate = nil;
    _webView.delegate = nil;
    [self removeNotification];
}


- (UIProgressView*)loadingProgressView {
    if (!_loadingProgressView) {
        _loadingProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, NAVI_HEIGHT, self.view.bounds.size.width, 2)];
        _loadingProgressView.progressTintColor = [UIColor colorWithHexString:@"FF4444"];
    }
    return _loadingProgressView;
}

- (UIRefreshControl*)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc]init];
        [_refreshControl addTarget:self action:@selector(webViewReload) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (void)webViewReload {
    [_webView reload];
    [_wk_WebView reload];
}

- (UIButton*)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.frame = CGRectMake(0, 0, 150, 150);
        _reloadButton.center = self.view.center;
        _reloadButton.layer.cornerRadius = 75.0;
        [_reloadButton setBackgroundImage:[UIImage imageNamed:@"sure_placeholder_error"] forState:UIControlStateNormal];
        [_reloadButton setTitle:@"您的网络有问题，请检查您的网络设置" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        _reloadButton.titleLabel.numberOfLines = 0;
        _reloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGRect rect = _reloadButton.frame;
        rect.origin.y -= 100;
        _reloadButton.frame = rect;
        _reloadButton.enabled = NO;
    }
    return _reloadButton;
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
    if ([_webView canGoBack] || [_wk_WebView canGoBack]) {
        [_webView goBack];
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
    
    //TODO:kvo监听，获得页面title和加载进度值
    
    [self.wk_WebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self addNotification];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    if (self.navigationController.viewControllers.count > 1) {
        self.delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
#pragma mark KVO的监听代理

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.interactivePopGestureRecognizer.delegate = self.delegate;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark 加载请求
- (void)loadRequest {
    if (![self.url hasPrefix:@"http"]) {//是否具有http前缀
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [_wk_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
}

#pragma mark WebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    webView.hidden = NO;
    // 不加载空白网址
    if ([request.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //导航栏配置
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self showLeftBarButtonItem];
    [_refreshControl endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    webView.hidden = YES;
}

#pragma mark WKNavigationDelegate

#pragma mark 加载状态回调
//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    webView.hidden = NO;
    _loadingProgressView.hidden = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 启动状态栏网络请求指示
    NSString *currentURL = webView.URL.absoluteString;
    self.weburl = currentURL;
    
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //导航栏配置
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationItem.title = title;
        self.title = title;
    }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态栏网络请求指示
    [self showLeftBarButtonItem];
    
    
    
    
//    NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
//    [webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        if(![response isEqual:[NSNull null]] && response != nil){
//            //截获到视频地址了
//            NSLog(@"response == %@",response);
//            
//            
//            
//            
//            
//            
////           // NSString *kit = [NSString stringWithFormat:@"%@",response];
////            
////            NSString *str1 = @"http://yyygwz.com/index.php?url=";
////          //  NSString *str2 = [NSString stringWithFormat:@"%@",self.url];
////            
////            NSString *str = [NSString stringWithFormat:@"%@%@",str1,self.weburl];
////            
////            NSLog(@"url-------%@",str);
////            
////           // str = @"https://www.baidu.com";
////            
////           // if (kit.length!=0) {
////                [_wk_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
////                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
////                
//////            }
// 
//        }else{
//            //没有视频链接
//        }
//    }];
    
}
// 主机地址被重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    webView.hidden = YES;
}

//HTTPS认证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}












#pragma mark Notification
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(beginPlayVideo:)
                                                 name:UIWindowDidBecomeVisibleNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endPlayVideo:)
                                                 name:UIWindowDidBecomeHiddenNotification
                                               object:self.view.window];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIWindowDidBecomeVisibleNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIWindowDidBecomeHiddenNotification
                                                  object:nil];
}

-(void)beginPlayVideo:(NSNotification *)notification{
//        //如果是alertview或者actionsheet的话也会执行到这里，所以要判断一下
//        if ([[UIApplication sharedApplication].keyWindow isMemberOfClass:[UIWindow class]]){
//              //  [playButton removeFromSuperview];
//            }
    
//    if ([[UIApplication sharedApplication].keyWindow isKindOfClass:[UIWindow class]]) {
//        
//    }
//    else
//    {
//  }
    
    if ([_webView canGoBack] || [_wk_WebView canGoBack]) {
        playerVC *vc = [[playerVC alloc] init];
        if ([self.typestr isEqualToString:@"斗鱼"]||[self.typestr isEqualToString:@"虎牙"]) {
            NSString *str = self.weburl;
            vc.urlstr = str;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            NSString *str1 = @"http://www.chepeijian.cn/jiexi/vip.php?url=";
            NSString *str = [NSString stringWithFormat:@"%@%@",str1,self.weburl];
            vc.urlstr = str;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addNotification];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeNotification];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 启动状态栏网络请求指示
    
}

-(void)endPlayVideo:(NSNotification *)notification{

    NSLog(@"播放结束");
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
