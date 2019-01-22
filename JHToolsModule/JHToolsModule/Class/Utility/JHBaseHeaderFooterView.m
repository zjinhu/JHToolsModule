//
//  JHBaseHeaderFooterView.m
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import "JHBaseHeaderFooterView.h"

@implementation JHBaseHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backColor = [UIColor whiteColor];
        [self setUpViews];
    }
    return self;
}

-(void)setBackColor:(UIColor *)backColor{
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = backColor;
        view;
    });
}

- (void)setUpViews{
    //初始化视图
}

- (CGFloat)getHeight{
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    //根据masonry撑开的contentView获取cell当前高度,可能用到的地方是缓存高度
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

@end
