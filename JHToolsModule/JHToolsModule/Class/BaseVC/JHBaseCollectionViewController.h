//
//  JHBaseCollectionViewController.h
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseViewController.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
#import <MJRefresh/MJRefresh.h>
#import "Utility.h"
NS_ASSUME_NONNULL_BEGIN

@interface JHBaseCollectionViewController : JHBaseViewController

- (instancetype)initVerCollectionViewController;
- (instancetype)initHorCollectionViewController;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray * mainDataArr;
/**
 *  初始化
 */
- (void)initData;

/**
 *  加载更多回调函数
 */
- (void)loadMoreData;

/**
 *  下拉刷新回调函数
 */
- (void)refreshData;

/**
 *  停止刷新
 */
- (void)endRefreshing;

/**
 *  隐藏显示上下拉加载
 */
-(void)showRefreshHeader;
-(void)hiddenRefreshHeader;
-(void)showRefreshFooter;
-(void)hiddenRefreshFooter;
@end

NS_ASSUME_NONNULL_END
