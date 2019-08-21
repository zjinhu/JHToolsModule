//
//  JHBaseCollectionViewController.m
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseCollectionViewController.h"

@interface JHBaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation JHBaseCollectionViewController

-(void)setupLayout{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupLayout];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return self;
}

- (instancetype)initVerCollectionViewController{
    if (self = [super init]) {
        [self setupLayout];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return self;
}

- (instancetype)initHorCollectionViewController{
    if (self = [super init]) {
        [self setupLayout];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    if (!_flowLayout) {
        [self setupLayout];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.delaysContentTouches = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    if (@available(iOS 11.0, *)) {
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }else{
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    
    __weak typeof (self) weakSelf = self;
    /**
     *  添加上拉刷新
     */
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    /**
     *  添加下拉加载
     */
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    /**
     *  初始隐藏
     */
    _collectionView.mj_header.hidden = YES;
    _collectionView.mj_footer.hidden = YES;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)){
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;//获取所有的手势
    //当是侧滑手势的时候设置panGestureRecognizer需要UIScreenEdgePanGestureRecognizer失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [_collectionView.panGestureRecognizer requireGestureRecognizerToFail:gesture];
        }
    }
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

- (void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout{
    _flowLayout = flowLayout;
    _collectionView.collectionViewLayout = flowLayout;
    [_collectionView reloadData];
}

#pragma mark 代理方法
//返回section 的数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回对应section的item 的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _mainDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
//    cell.backgroundColor = ColorOfRandom;
    return cell;
}
////设置item的大小
////item的默认大小：50*50
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    //第一个参数：设置item的宽
//    //第二个参数：设置item的高
//    return CGSizeMake(100, 120);
//}
////120 + 100 +120 +100  - 460    20
////设置水平间隙  ： 默认10
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 50;
//}
////设置竖直间隙  ： 默认10
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 50;
//}
////设置边距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    //上左下右
//    return UIEdgeInsetsMake(10 ,10, 10, 10);
//}
#pragma mark 数据操作
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

- (void)endRefreshing{
    [_collectionView.mj_footer endRefreshing];
    [_collectionView.mj_header endRefreshing];
}
#pragma mark 下拉刷新
-(void)showRefreshHeader{
    _collectionView.mj_header.hidden = NO;
}
-(void)hiddenRefreshHeader{
    _collectionView.mj_header.hidden = YES;
}

-(void)hiddenRefreshFooter{
    _collectionView.mj_footer.hidden = YES;
}
-(void)showRefreshFooter{
    _collectionView.mj_footer.hidden = NO;
}
@end
