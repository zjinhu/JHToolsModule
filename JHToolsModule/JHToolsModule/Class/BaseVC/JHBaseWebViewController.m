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
@interface JHBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
@property (nonatomic, strong) UIProgressView *loadingProgressView;//进度条
@property (nonatomic, strong) UIButton *reloadBtn;//重新加载的按钮
@property (nonatomic, strong) NSString *currentPageUrl;//重新加载的url

@end

@implementation JHBaseWebViewController

- (instancetype)initWithLoadURL:(NSString *)urlString
{
    if (self = [super init]) {
        _url = urlString;
    }
    return self;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
    self.webView.scrollView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = self.navTitle;
    [self.view addSubview:self.reloadBtn];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.preferences = [[WKPreferences alloc]init];
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences.javaScriptEnabled = YES;
    config.allowsInlineMediaPlayback = YES;
    ////JS 方式注入cookie
    NSString *cookieValue= @"";
    if ([UserDefaults boolForKey:@"isLogin"] && _supportAutoLogin) {
        NSString *token = [UserDefaults valueForKey:@"Access_token"];
        NSLog(@"token=%@",token);
        cookieValue = [NSString stringWithFormat:@"document.cookie = '%@=%@';", @"access_token", token];
    }
    if (cookieValue.length>2) {
        //添加在js中操作的对象名称，通过该对象来向web view发送消息
        WKUserScript * cookieScript = [[WKUserScript alloc]initWithSource:cookieValue injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [config.userContentController addUserScript:cookieScript];
    }
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    [self.webView setCustomUserAgent:@"iOSApp"];
    //添加此属性可触发侧滑返回上一网页与下一网页操作
    self.webView.allowsBackForwardNavigationGestures = YES;
    //进度条的监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    //        __weak typeof (self) wself = self;
    //        [_webView.scrollView addPullToRefresh:[JHRefreshHeaderAnimator createAnimator] block:^{
    //            [wself.webView reload];
    //        }];
    [self.view addSubview:self.webView];
    
    if (@available(iOS 11.0, *)) {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }else{
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    [self.view addSubview:self.loadingProgressView];
    
    [self loadRequest];
    
    
    //注册方法
    [[self.webView configuration].userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"JumpViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark WK Delegate

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@--%@",message.name, message.body);
    if ([message.name isEqualToString:@"JumpViewController"]) {
        //        TOO:H5跳转任意页面

    }
    
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
    self.webView.hidden = NO;
    self.loadingProgressView.hidden = NO;
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.webView.hidden = NO;
    self.reloadBtn.hidden = YES;
    //导航栏配置
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationItem.title = title;
    }];
    if ([UserDefaults boolForKey:@"isLogin"] && _supportAutoLogin) {
        NSString *token = [UserDefaults valueForKey:@"Access_token"];
        NSLog(@"token=%@",token);
        NSString *cookieValue = [NSString stringWithFormat:@"document.cookie = '%@=%@';", @"access_token", token];
        [self.webView evaluateJavaScript:cookieValue completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"result --- %@\n error --- %@",result, error);
        }];
    }
//    [_webView.scrollView endRefreshing];
}

//4.页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    self.webView.hidden = YES;
    self.reloadBtn.hidden = NO;
//    [_webView.scrollView endRefreshing];
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

- (UIProgressView*)loadingProgressView {
    if (!_loadingProgressView) {
        _loadingProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        _loadingProgressView.progressTintColor = [UIColor baseTileBlueColor];
        _loadingProgressView.trackTintColor = [UIColor clearColor];
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
    if (self.webView.canGoBack) {
        [self.webView goBack];
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
    @weakify(self);
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        if (progress >= self.loadingProgressView.progress) {
            [self.loadingProgressView setProgress:progress animated:YES];
        }
        if (self.loadingProgressView.progress == 1) {
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                @strongify(self);
                self.loadingProgressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                self.loadingProgressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)reloadBtnClick {
    self.loadingProgressView.progress = 0;
    self.loadingProgressView.hidden = NO;//重置进度条
    /**
     WebView在第一次加载页面如果没网络时，是没办法reload的，即使你再次打开网络，reload也是没法办刷新的。此处直接通过 loadRequest 方法来实现没网络时候仍然可以重新加载页面的用户体验
     */
    [self.webView loadRequest:[self loadUrl:_currentPageUrl]];
}

- (void)loadRequest {
    [self clearWbCache];
    if (_url) {
        [self.webView loadRequest:[self loadUrl:_url]];
    }
}

-(NSMutableURLRequest *)loadUrl:(NSString *)str{
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    ////首次加载写入cookie    PHP网页方式
    if ([UserDefaults boolForKey:@"isLogin"] && _supportAutoLogin) {
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
