//
//  JHBaseCollectionReusableView.m
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseCollectionReusableView.h"

@implementation JHBaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    //初始化视图
}

- (void)setWithModel:(id)model{//设置 model
    
}

- (CGFloat)getHeightWithModel:(id)model{//设置 model并拿到高度
    [self setWithModel:model];
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    //根据masonry撑开的contentView获取cell当前高度,可能用到的地方是缓存高度
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}


#pragma mark - register cell tools

+ (void)registerHeaderFooterView:(UICollectionView *)collectionView
                   forViewOfKind:(CollectionReusableViewType)forViewOfKind
                 reuseIdentifier:(NSString *)reuseIdentifier{
    
    [collectionView registerClass:[self class]
       forSupplementaryViewOfKind:forViewOfKind == CollectionReusableViewHeader ?UICollectionElementKindSectionHeader:UICollectionElementKindSectionFooter
              withReuseIdentifier:reuseIdentifier];
}

+ (void)registerHeaderFooterView:(UICollectionView *)collectionView
                   forViewOfKind:(CollectionReusableViewType)forViewOfKind{
    
    [collectionView registerClass:[self class]
       forSupplementaryViewOfKind:forViewOfKind == CollectionReusableViewHeader ?UICollectionElementKindSectionHeader:UICollectionElementKindSectionFooter
              withReuseIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)dequeueReusableHeaderFooterView:(UICollectionView *)collectionView
                                  forViewOfKind:(CollectionReusableViewType)forViewOfKind
                                reuseIdentifier:(NSString *)reuseIdentifier
                                   forIndexPath:(NSIndexPath *)indexPath{
    
    return [collectionView dequeueReusableSupplementaryViewOfKind:forViewOfKind == CollectionReusableViewHeader ?UICollectionElementKindSectionHeader:UICollectionElementKindSectionFooter
                                              withReuseIdentifier:reuseIdentifier
                                                     forIndexPath:indexPath];
}

+ (instancetype)dequeueReusableHeaderFooterView:(UICollectionView *)collectionView
                                  forViewOfKind:(CollectionReusableViewType)forViewOfKind
                                   forIndexPath:(NSIndexPath *)indexPath{
   return [collectionView dequeueReusableSupplementaryViewOfKind:forViewOfKind == CollectionReusableViewHeader ?UICollectionElementKindSectionHeader:UICollectionElementKindSectionFooter
                                             withReuseIdentifier:NSStringFromClass([self class])
                                                    forIndexPath:indexPath];
}
@end
