//
//  JHBaseCollectionViewCell.h
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseCollectionViewCell : UICollectionViewCell
- (void)setUpCellViews;//初始化cell 视图

- (void)setCellWithModel:(id)model;//设置cell model

- (CGFloat)getCellHeightWithModel:(id)model;//设置cell model并拿到cell高度

#pragma mark - register cell tools

+ (void)registerCell:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerCell:(UICollectionView *)collectionView;

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
