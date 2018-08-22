//
//  JHBaseWebViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHBaseWebViewController.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
#import "NSObject+BlockSEL.h"
#import "LNRefresh.h"
#import "JHRefreshHeaderAnimator.h"
#import "WeakScriptMessageDelegate.h"
#import "UserDefaults.h"
@interface JHBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIProgressView *loadingProgressView;//进度条
@property (nonatomic, strong) UIButton *reloadBtn;//重新加载的按钮
@property (nonatomic, strong) NSString *currentPageUrl;//重新加载的url

@end

@implementation JHBaseWebViewController

- (instancetype)initWithLoadURL:(NSString *)urlString
{
    if (self = [super init]) {
        self.url = urlString;
    }
    return self;
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView stopLoading];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _reloadBtn = nil;
    _loadingProgressView = nil;
    _webView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = self.navTitle;
    [self.view addSubview:self.reloadBtn];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.loadingProgressView];
    
    [self loadRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    //    //读取wkwebview中的cookie 方法 读取Set-Cookie字段
    //    NSString *cookieString = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
    //    NLog(@"wkwebview中的cookie :%@", cookieString);
    //    //看看存入到了NSHTTPCookieStorage了没有
    //    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    for (NSHTTPCookie *cookie in cookieJar.cookies) {
    //        NLog(@"NSHTTPCookieStorage中的cookie%@", cookie);
    //    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }
    //发送请求前，存一份当前页面url，留作加载失败点击重现加载时候用
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByRemovingPercentEncoding];
    _currentPageUrl = urlString;
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    _webView.hidden = NO;
    _loadingProgressView.hidden = NO;
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    _webView.hidden = NO;
    _reloadBtn.hidden = YES;
    //导航栏配置
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationItem.title = title;
    }];
    [_webView.scrollView endRefreshing];
}

//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    _webView.hidden = YES;
    _reloadBtn.hidden = NO;
    [_webView.scrollView endRefreshing];
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
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    //    NLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
#pragma mark -LazyLoading
- (WKWebView*)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences.javaScriptEnabled = YES;
        config.allowsInlineMediaPlayback = YES;
        ////JS 方式注入cookie
        NSString *cookieValue= @"";
        if ([UserDefaults boolForKey:@"isLogin"]) {
            NSString *token = [UserDefaults valueForKey:@"Access_token"];
            NSLog(@"token=%@",token);
            cookieValue = [NSString stringWithFormat:@"document.cookie = '%@=%@';", @"access_token", token];
        }
        if (cookieValue.length>2) {
            //添加在js中操作的对象名称，通过该对象来向web view发送消息
            WKUserScript * cookieScript = [[WKUserScript alloc]initWithSource:cookieValue injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
            [config.userContentController addUserScript:cookieScript];
        }
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) configuration:config];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        //添加此属性可触发侧滑返回上一网页与下一网页操作
        _webView.allowsBackForwardNavigationGestures = YES;
        //进度条的监听
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        
        __weak typeof (self) wself = self;
        [_webView.scrollView addPullToRefresh:[JHRefreshHeaderAnimator createAnimator] block:^{
            [wself.webView reload];
        }];
        
    }
    return _webView;
}


- (UIProgressView*)loadingProgressView {
    if (!_loadingProgressView) {
        _loadingProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 2)];
        _loadingProgressView.progressTintColor = [UIColor baseTileBlueColor];
    }
    return _loadingProgressView;
}

-(UIButton *)reloadBtn{
    if (!_reloadBtn) {
        NSMutableAttributedString *attrubutStr = [[NSMutableAttributedString alloc] initWithString:@"加载失败,请点击重试"];
        [attrubutStr addAttribute:NSFontAttributeName value:Font(15) range:NSMakeRange(0, attrubutStr.length)];
        [attrubutStr addAttribute:NSForegroundColorAttributeName value:[UIColorFromName(0x000000) colorWithAlphaComponent:0.7] range:NSMakeRange(0, attrubutStr.length)];
        
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadBtn.frame = CGRectMake(0, (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)/2 - 50, SCREEN_WIDTH, 100);
        [_reloadBtn setAttributedTitle:attrubutStr forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(reloadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}


#pragma mark Action
- (void)goBack {
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self closeVC];
    }
}

- (void)closeVC {
    [self cleanAllWebsiteDataStore];//清楚缓存
    if (self.navigationController &&self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//kvo监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    WS(weakSelf);
    if ([keyPath isEqualToString:@"estimatedProgress"]) {//进度条
        _loadingProgressView.progress = [change[@"new"] floatValue];
        if (_loadingProgressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.loadingProgressView.hidden = YES;
            });
        }
    }
}

- (void)reloadBtnClick {
    _loadingProgressView.progress = 0;
    _loadingProgressView.hidden = NO;//重置进度条
    /**
     WebView在第一次加载页面如果没网络时，是没办法reload的，即使你再次打开网络，reload也是没法办刷新的。此处直接通过 loadRequest 方法来实现没网络时候仍然可以重新加载页面的用户体验
     */
    [_webView loadRequest:[self loadUrl:_currentPageUrl]];
}

- (void)loadRequest {
    [self clearWbCache];
    [_webView loadRequest:[self loadUrl:_url]];
}

-(NSMutableURLRequest *)loadUrl:(NSString *)str{
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    ////首次加载写入cookie    PHP网页方式
    if ([UserDefaults boolForKey:@"isLogin"]) {
        NSString *token = [UserDefaults valueForKey:@"Access_token"];
        NSLog(@"token=%@",token);
        [request setValue:[NSString stringWithFormat:@"%@=%@",@"access_token",token] forHTTPHeaderField:@"Cookie"];
    }
    return request;
}
#pragma mark 清除缓存
- (void)cleanAllWebsiteDataStore{
    //清除所有缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    // Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    // Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
    }];
}
- (void)clearWbCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}
@end
