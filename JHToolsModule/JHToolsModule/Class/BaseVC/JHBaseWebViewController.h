//
//  JHBaseWebViewController.h
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHBaseViewController.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface JHBaseWebViewController : JHBaseViewController
@property (nonatomic, strong) WKWebView *webView;     //webview
@property (nonatomic, strong) NSString *navTitle;     //页面标题
@property (nonatomic, assign) BOOL supportAutoLogin;  //默认不支持
@property (nonatomic, strong) NSString *url;
- (void)setNavgationItem;

- (instancetype)initWithLoadURL:(NSString *)urlString;

- (void)cleanAllWebsiteDataStore;

- (void)closeVC;
@end
