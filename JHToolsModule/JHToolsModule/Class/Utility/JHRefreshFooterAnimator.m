//
//  IKRefreshFooterAnimator.m
//  IKToolsModule
//
//  Created by HU on 2018/8/1.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHRefreshFooterAnimator.h"

@interface JHRefreshFooterAnimator ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation JHRefreshFooterAnimator

+ (instancetype)createAnimator {
    JHRefreshFooterAnimator *diyAnimator = [[JHRefreshFooterAnimator alloc]init];
    return diyAnimator;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = LNRefreshLabelFont;
        _titleLabel.textColor = LNRefreshLabelTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

- (void)setupSubViews {
    [super setupSubViews];
    [self.animatorView addSubview:self.titleLabel];
    [self.animatorView addSubview:self.indicatorView];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    CGSize size = self.animatorView.bounds.size;
    CGFloat viewW = size.width;
    CGFloat viewH = size.height;
    [UIView performWithoutAnimation:^{
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(viewW/2.0, viewH/2.0);
        self.indicatorView.center = CGPointMake(self.titleLabel.frame.origin.x - 16.0, viewH/2.0);
    }];
}

- (void)refreshView:(LNRefreshComponent *)view state:(LNRefreshState)state {
    if (self.state == state) { return; }
    self.state = state;
    switch (state) {
        case LNRefreshState_Normal:
            [self endRefreshAnimation:view];
            break;
        case LNRefreshState_Refreshing:
            [self startRefreshAnimation:view];
            break;
        case LNRefreshState_NoMoreData:
            [self endRefreshAnimation:view];
            self.titleLabel.text = @"没有更多内容";
            break;
        default:
            break;
    }
    [self layoutSubviews];
}

- (void)startRefreshAnimation:(LNRefreshComponent *)view {
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
    self.titleLabel.text = @"加载中";
    [self layoutSubviews];
}

- (void)endRefreshAnimation:(LNRefreshComponent *)view {
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
    self.titleLabel.text = @"加载更多";
    [self layoutSubviews];
}
@end
