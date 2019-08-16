//
//  JHBaseCollectionReusableView.h
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CollectionReusableViewType) {
    CollectionReusableViewHeader, //default
    CollectionReusableViewFooter,
};
NS_ASSUME_NONNULL_BEGIN

@interface JHBaseCollectionReusableView : UICollectionReusableView

- (void)setUpViews;//初始化视图

- (void)setWithModel:(id)model;//设置 model

- (CGFloat)getHeightWithModel:(id)model;//设置 model并拿到高度

#pragma mark - register cell tools

+ (void)registerHeaderFooterView:(UICollectionView *)collectionView
                   forViewOfKind:(CollectionReusableViewType)forViewOfKind
                 reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerHeaderFooterView:(UICollectionView *)collectionView
                   forViewOfKind:(CollectionReusableViewType)forViewOfKind;

+ (instancetype)dequeueReusableHeaderFooterView:(UICollectionView *)collectionView
                                  forViewOfKind:(CollectionReusableViewType)forViewOfKind
                                reuseIdentifier:(NSString *)reuseIdentifier
                                   forIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)dequeueReusableHeaderFooterView:(UICollectionView *)collectionView
                                  forViewOfKind:(CollectionReusableViewType)forViewOfKind
                                   forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
