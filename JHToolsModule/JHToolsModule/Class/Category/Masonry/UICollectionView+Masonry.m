//
//  UICollectionView+Masonry.m
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UICollectionView+Masonry.h"

@implementation UICollectionView (Masonry)

+ (instancetype)masCollectionViewWithDelegate:(id)delegate
                                   horizontal:(BOOL)isHorizontal
                                    superView:(UIView *)superView {
    return [self masCollectionViewWithDelegate:delegate
                                    horizontal:isHorizontal
                                          size:CGSizeZero
                                   itemSpacing:0
                                   lineSpacing:0
                                     superView:superView
                                   constraints:nil];
}

+ (instancetype)masCollectionViewWithDelegate:(id)delegate
                                   horizontal:(BOOL)isHorizontal
                                         size:(CGSize)itemSize
                                    superView:(UIView *)superView {
    return [self masCollectionViewWithDelegate:delegate
                                    horizontal:isHorizontal
                                          size:itemSize
                                   itemSpacing:0
                                   lineSpacing:0
                                     superView:superView
                                   constraints:nil];
}

+ (instancetype)masCollectionViewWithDelegate:(id)delegate
                                   horizontal:(BOOL)isHorizontal
                                         size:(CGSize)itemSize
                                  itemSpacing:(CGFloat)minimumInteritemSpacing
                                  lineSpacing:(CGFloat)minimumLineSpacing
                                    superView:(UIView *)superView {
    return [self masCollectionViewWithDelegate:delegate
                                    horizontal:isHorizontal
                                          size:itemSize
                                   itemSpacing:minimumInteritemSpacing
                                   lineSpacing:minimumLineSpacing
                                     superView:superView
                                   constraints:nil];
}

+ (instancetype)masCollectionViewWithDelegate:(id)delegate
                                   horizontal:(BOOL)isHorizontal
                                         size:(CGSize)itemSize
                                  itemSpacing:(CGFloat)minimumInteritemSpacing
                                  lineSpacing:(CGFloat)minimumLineSpacing
                                    superView:(UIView *)superView
                                  constraints:(JHConstrainMaker)constraints {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = itemSize;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    layout.minimumLineSpacing = minimumLineSpacing;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.pagingEnabled = YES;
    collection.delegate = delegate;
    collection.dataSource = delegate;
    collection.showsHorizontalScrollIndicator = NO;
    [superView addSubview:collection];
    
    if (isHorizontal) {
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = YES;
    } else {
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        collection.showsVerticalScrollIndicator = YES;
        collection.showsHorizontalScrollIndicator = NO;
    }
    
    if (superView) {
        if (constraints) {
            [collection mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(superView);
            }];
        }
    }
    
    return collection;
}
@end
