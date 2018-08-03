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
    [self setNavgationItem];
    [self.view addSubview:self.reloadBtn];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.loadingProgressView];
    
    [self loadRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavgationItem {
    [self setLeftBarButtonWithImage:ImageNamed(@"") AndHighLightImage:ImageNamed(@"")];
    //[self setRightBarButtonWithImage:ImageNamed(@"faxian_guanbi") AndHighLightImage:ImageNamed(@"faxian_guanbi_anxia")];
    [self.leftBarButton selectorBlock:^(id weakSelf, id arg) {
        [weakSelf closeVC];
    }];
}
#pragma mark 加载请求
- (void)loadRequest {
    NSURL *url = [NSURL URLWithString:_url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:[self headerCookie] forHTTPHeaderField:@"Cookie"];
    [_webView loadRequest:request];
}
#pragma mark WKNavigationDelegate

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

#pragma mark -LazyLoading
- (WKWebView*)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences.javaScriptEnabled = YES;
        config.allowsInlineMediaPlayback = YES;
        NSString *cookieValue = @"";
        if (self.supportAutoLogin) {
            cookieValue = [self documentCookie:YES];
        }else{
            cookieValue = [self documentCookie:NO];
        }
        WKUserContentController* userContentController = WKUserContentController.new;
        WKUserScript * cookieScript = [[WKUserScript alloc]
                                       initWithSource: cookieValue
                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        config.userContentController = userContentController;
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
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
    [self popOrGoBack];
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

- (void)popOrGoBack{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self closeVC];
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
    NSURL *url = [NSURL URLWithString:[_currentPageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];//将url中 中文 进行编码
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:[self headerCookie] forHTTPHeaderField:@"Cookie"];
    [_webView loadRequest:request];
}


- (NSString *)documentCookie:(BOOL)containLoginInfo {
    NSString *ret = @"";
    NSMutableString *tempStr = [[NSMutableString alloc] initWithCapacity:3];
    [tempStr appendString:([NSString stringWithFormat:@"document.cookie = 'platform=%@';", @"ios"])];
    //    if (containLoginInfo) {
    //        if ([AccountInfoModel isLogin]) {
    //            AccountInfoModel *account = [AccountInfoModel getCurrentSaveModel];
    //            [tempStr appendString:([NSString stringWithFormat:@"document.cookie = 'token=%@';", account.token])];
    //            [tempStr appendString:([NSString stringWithFormat:@"document.cookie = 'userid=%@';", account.uid])];
    //        }
    //    }
    ret = tempStr;
    return ret;
}


- (NSString *)headerCookie {
    NSString *ret = @"";
    NSMutableString *tempStr = [[NSMutableString alloc] initWithCapacity:3];
    //    if ([AccountInfoModel isLogin]) {
    //        AccountInfoModel *account = [AccountInfoModel getCurrentSaveModel];
    //
    //        [tempStr appendString:([NSString stringWithFormat:@"token=%@ ", account.token])];
    //        [tempStr appendString:([NSString stringWithFormat:@"userid=%@ ;", account.uid])];
    //    }
    [tempStr appendString:([NSString stringWithFormat:@"platform=%@ ;", @"ios"])];
    ret = tempStr;
    return ret;
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
@end
