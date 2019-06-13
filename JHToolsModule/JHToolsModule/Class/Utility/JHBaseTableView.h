//
//  JHBaseTableView.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/6/13.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseTableView : UITableView
#pragma mark - 数据设置
///设置所有数据数组
@property(nonatomic, strong)NSMutableArray *mainDataArr;
///声明cell的类
@property (nonatomic, copy) Class (^setCellClassAtIndexPath)(NSIndexPath *indexPath);
///设置cell的高度(非必须，若设置了，则内部的自动计算高度无效)
@property (nonatomic, copy) CGFloat (^setCellHeightAtIndexPath)(NSIndexPath *indexPath);
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) CGFloat (^setCountOfSectionsInTableView)(UITableView *tableView);
///设置对应section中row的数量(非必须，若设置了，则内部自动设置对应section中row的数量无效)
@property (nonatomic, copy) CGFloat (^setCountOfRowsInSection)(NSUInteger section);
///根据HeaderView类名设置HeaderView，写了此方法则zx_setHeaderViewInSection无效，无需实现zx_setHeaderHInSection，自动计算高度
@property (nonatomic, copy) Class (^setHeaderClassInSection)(NSInteger section);
///根据FooterView类名设置FooterView，写了此方法则zx_setFooterViewInSection无效，无需实现zx_setFooterHInSection，自动计算高度
@property (nonatomic, copy) Class (^setFooterClassInSection)(NSInteger section);
///设置HeaderView，必须实现zx_setHeaderHInSection
@property (nonatomic, copy) UIView *(^setHeaderViewInSection)(NSInteger section);
///设置FooterView，必须实现zx_setFooterHInSection
@property (nonatomic, copy) UIView *(^setFooterViewInSection)(NSInteger section);
///设置HeaderView高度，非必须，若设置了则自动设置的HeaderView高度无效
@property (nonatomic, copy) CGFloat (^setHeaderHeightInSection)(NSInteger section);
///设置FooterView高度，非必须，若设置了则自动设置的FooterView高度无效
@property (nonatomic, copy) CGFloat (^setFooterHeightInSection)(NSInteger section);
///禁止系统Cell自动高度 可以有效解决tableView跳动问题，默认为NO
@property(nonatomic, assign)BOOL disableAutomaticDimension;
///无数据是否显示HeaderView，默认为YES
@property(nonatomic, assign)BOOL showHeaderWhenNoData;
///无数据是否显示FooterView，默认为YES
@property(nonatomic, assign)BOOL showFooterWhenNoData;

#pragma mark - 数据获取
///获取对应行的cell，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^getCellAtIndexPath)(NSIndexPath *indexPath,id cell);
///获取对应section的headerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) void (^getHeaderViewInSection)(NSUInteger section,id headerView,NSMutableArray *secArr);
///获取对应section的footerView，把id改成对应类名即可无需强制转换，secArr为对应section的model数组
@property (nonatomic, copy) void (^getFooterViewInSection)(NSUInteger section,id footerView,NSMutableArray *secArr);
#pragma mark - 快速构建
///声明cell的类并返回cell对象
-(void)setCellClassAtIndexPath:(Class (^)(NSIndexPath * indexPath)) setCellClassCallBack returnCell:(void (^)(NSIndexPath * indexPath,id cell))returnCellCallBack;
///声明HeaderView的类并返回HeaderView对象
-(void)setHeaderClassInSection:(Class (^)(NSInteger)) setHeaderClassCallBack returnHeader:(void (^)(NSUInteger section,id headerView,NSMutableArray *secArr))returnHeaderCallBack;
///声明FooterView的类并返回FooterView对象
-(void)setFooterClassInSection:(Class (^)(NSInteger)) setFooterClassCallBack returnHeader:(void (^)(NSUInteger section,id headerView,NSMutableArray *secArr))returnFooterCallBack;
#pragma mark - 代理事件相关
///选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^didSelectedAtIndexPath)(NSIndexPath *indexPath,id cell);
///取消选中某一行，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^didDeselectedAtIndexPath)(NSIndexPath *indexPath,id cell);
///滑动编辑
@property (nonatomic, copy) NSArray<UITableViewRowAction *>* (^editActionsForRowAtIndexPath)(NSIndexPath *indexPath);
///cell将要展示，把id改成对应类名即可无需强制转换
@property (nonatomic, copy) void (^willDisplayCell)(NSIndexPath *indexPath,id cell);
///scrollView滚动事件
@property (nonatomic, copy) void (^scrollViewDidScroll)(UIScrollView *scrollView);
///scrollView缩放事件
@property (nonatomic, copy) void (^scrollViewDidZoom)(UIScrollView *scrollView);
///scrollView滚动到顶部事件
@property (nonatomic, copy) void (^scrollViewDidScrollToTop)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^scrollViewWillBeginDragging)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);
#pragma mark - UITableViewDataSource & UITableViewDelegate
///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UITableViewDataSource> tableDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UITableViewDelegate> tableDelegate;
@end

NS_ASSUME_NONNULL_END
