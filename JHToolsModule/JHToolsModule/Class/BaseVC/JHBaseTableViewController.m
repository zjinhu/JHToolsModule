//
//  JHBaseTableViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
#import "LNRefresh.h"
#import "Utility.h" 
@interface JHBaseTableViewController ()

@end

@implementation JHBaseTableViewController

- (void)setTableViewStyleGrouped{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  初始化
     */
    [self initData];
    [self setTableViewStyleGrouped];
    if (_tableViewType == TableViewStylePlain) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
    }
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor baseLineColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.delaysContentTouches = YES;
    [self.view addSubview:_tableView];
    
    if (self.shouldAdjustSafeArea) {
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.bottom.equalTo(self.view.mas_bottom).offset(-HOME_INDICATOR_HEIGHT);
        }];
    }else{
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    __weak typeof (self) weakSelf = self;
    /**
     *  添加上拉刷新
     */
    [_tableView addPullToRefresh:[JHRefreshHeaderAnimator createAnimator] block:^{
        [weakSelf refreshData];
    }];
    /**
     *  添加下拉加载
     */
    [_tableView addInfiniteScrolling:[JHRefreshFooterAnimator createAnimator] block:^{
        [weakSelf loadMoreData];
    }];
    /**
     *  初始隐藏
     */
    _tableView.ln_header.hidden = YES;
    _tableView.ln_footer.hidden = YES;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if (@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;//获取所有的手势
    //当是侧滑手势的时候设置panGestureRecognizer需要UIScreenEdgePanGestureRecognizer失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [_tableView.panGestureRecognizer requireGestureRecognizerToFail:gesture];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mainDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
#pragma mark 事件

/**
 *  初始化
 */
- (void)initData{
    //    [self showLoadingView];
    _mainDataArr = [NSMutableArray array];
}

/**
 *  加载更多回调函数
 */
- (void)loadMoreData{
    
}
/**
 *  下拉刷新回调函数
 */

- (void)refreshData{
    
}

- (void)endTableViewRefreshing{
        [_tableView endRefreshing];
        [_tableView endLoadingMore];
}

- (void)setUnDelaysContentTouches:(BOOL)unDelaysContentTouches{
    
    _tableView.delaysContentTouches = unDelaysContentTouches;
    _unDelaysContentTouches = unDelaysContentTouches;
}
#pragma mark 下拉刷新
-(void)showRefreshHeader{
    [_tableView showRefreshHeader];
}
-(void)hiddenRefreshHeader{
    [_tableView hideRefreshHeader];
}

-(void)hiddenRefreshFooter{
    [_tableView hideRefreshFooter];
}
-(void)showRefreshFooter{
    [_tableView showRefreshFooter];
}
@end
