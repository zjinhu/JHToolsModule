//
//  JHBaseViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//
#define KNavigationBarButtonHeight 40

#import "JHBaseViewController.h"
#import "NSString+Base.h"
#import "BaseUI.h"

@interface JHBaseViewController ()

@end

@implementation JHBaseViewController

//判断是否二次展示页面
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if ([self isBeingPresented] || [self isMovingToParentViewController]) {
//        // push / present
//        NSLog(@"OneViewController push / present");
//    } else {
//        NSLog(@"OneViewController pop");
//        // pop to here
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  返回上一级页面
 */
- (void)goBack{
    if (self.navigationController &&self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  设置导航默认返回按钮
 */
- (void)setLeftBackBarButton{
    
    _leftBarButton = [[UIButton alloc] init];
    
    [_leftBarButton setImage:[UIImage imageNamed:@"daohang_fanhui1_anxai"] forState:UIControlStateHighlighted];
    [_leftBarButton setImage:[UIImage imageNamed:@"daohang_fanhui1"] forState:UIControlStateNormal];
    _leftBarButton.frame = CGRectMake(0, 0, KNavigationBarButtonHeight, KNavigationBarButtonHeight);
    
    [_leftBarButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
/**
 *  设置导航左侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage{
    
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, KNavigationBarButtonHeight, KNavigationBarButtonHeight);
    [_leftBarButton setImage:normalImage forState:UIControlStateNormal];
    [_leftBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}

/**
 *  设置导航左侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setLeftBarButtonWithText:(NSString *)text{
    
    CGSize buttonSize                     = [text getSizeWithFont:[UIFont menuFont]];
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    _leftBarButton.titleLabel.font        = [UIFont menuFont];
    [_leftBarButton setTitle:text forState:UIControlStateNormal];
    [_leftBarButton setTitle:text forState:UIControlStateHighlighted];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateNormal];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextHighLightColor forState:UIControlStateHighlighted];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
- (void)setLeftBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage AndText:(NSString *)text{
    CGSize textSize = [text getSizeWithFont:[UIFont baseFont]];
    CGFloat height = normalImage.size.height > textSize.height ? normalImage.size.height : textSize.height;
    CGFloat width = textSize.width + normalImage.size.width + 8;
    _leftBarButton                        = [[UIButton alloc] init];
    _leftBarButton.frame                  = CGRectMake(0, 0, width, height);
    _leftBarButton.titleLabel.font        = [UIFont baseFont];
    [_leftBarButton setImage:normalImage forState:UIControlStateNormal];
    [_leftBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    [_leftBarButton setTitle:text forState:UIControlStateNormal];
    [_leftBarButton setTitle:text forState:UIControlStateHighlighted];
    
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateNormal];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextColor forState:UIControlStateHighlighted];
    //    [_leftBarButton setTitleColor:BaseNaviBarTextDisableColor forState:UIControlStateDisabled];
    //    _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    //    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    //    self.navigationItem.leftBarButtonItem = leftButtonItem;
    //
    //    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    space.width = -4;
    //    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space,leftButtonItem, nil];
    UIBarButtonItem *leftButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    if (@available(ios 11.0,*)) {
        _leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _leftBarButton.contentEdgeInsets =UIEdgeInsetsMake(0, -10,0, 0);
        leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    } else {
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    }
}
/**
 *  设置导航右侧按钮图片
 *
 *  @param normalImage    正常图片
 *  @param highLightImage 高亮图片
 */
- (void)setRightBarButtonWithImage:(UIImage *)normalImage AndHighLightImage:(UIImage *)highLightImage{
    
    _rightBarButton                        = [[UIButton alloc] init];
    _rightBarButton.frame                  = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    [_rightBarButton setImage:normalImage forState:UIControlStateNormal];
    [_rightBarButton setImage:highLightImage forState:UIControlStateHighlighted];
    UIBarButtonItem *rightButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -4;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space,rightButtonItem, nil];
}
/**
 *  设置导航右侧按钮文本
 *
 *  @param text 导航按钮文本
 */
- (void)setRightBarButtonWithText:(NSString *)text{
    
    CGSize buttonSize                      = [text getSizeWithFont:[UIFont menuFont]];
    _rightBarButton                        = [[UIButton alloc] init];
    _rightBarButton.frame                  = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    _rightBarButton.titleLabel.font        = [UIFont menuFont];
    [_rightBarButton setTitle:text forState:UIControlStateNormal];
    [_rightBarButton setTitle:text forState:UIControlStateHighlighted];
    [_rightBarButton setTitleColor:[UIColor baseTextColor] forState:UIControlStateNormal];
    [_rightBarButton setTitleColor:[UIColor baseTextGrayColor]  forState:UIControlStateHighlighted];
    UIBarButtonItem *rightButtonItem       = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -4;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space,rightButtonItem, nil];
}
@end
