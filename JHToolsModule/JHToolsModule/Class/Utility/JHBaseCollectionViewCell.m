//
//  JHBaseCollectionViewCell.m
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseCollectionViewCell.h"

@implementation JHBaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setUpCellViews];
    }
    return self;
}

- (void)setUpCellViews{//初始化cell 视图
    
}

- (void)setCellWithModel:(id)model{//设置cell model
    
}

- (CGFloat)getCellHeightWithModel:(id)model{//设置cell model并拿到cell高度
    [self setCellWithModel:model];
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    //根据masonry撑开的contentView获取cell当前高度,可能用到的地方是缓存高度
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}
#pragma mark - register cell tools

+ (void)registerCell:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:reuseIdentifier];
}

+ (void)registerCell:(UICollectionView *)collectionView{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath{
     return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

+ (instancetype)dequeueReusableCell:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

@end
