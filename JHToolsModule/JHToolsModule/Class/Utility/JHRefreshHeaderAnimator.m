//
//  IKRefreshHeaderAnimator.m
//  IKToolsModule
//
//  Created by HU on 2018/7/31.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "JHRefreshHeaderAnimator.h"
@interface JHRefreshHeaderAnimator ()
@property (nonatomic, strong) NSMutableArray *gifViewImages;
@end

@implementation JHRefreshHeaderAnimator
+ (instancetype)createAnimator {
    JHRefreshHeaderAnimator *diyAnimator = [[JHRefreshHeaderAnimator alloc]init];
    diyAnimator.headerType = LNRefreshHeaderType_DIY;
    diyAnimator.trigger = 60;
    diyAnimator.incremental = 60;
    return diyAnimator;
}

- (void)setupHeaderView_DIY {
 
    self.gifViewImages = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 19; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_pull_%lu", (unsigned long)i]];
        [self.gifViewImages addObject:image];
    }
    [self.animatorView addSubview:self.gifView];
}

- (void)layoutHeaderView_DIY {
    CGRect react = self.animatorView.frame;
    self.gifView.frame = CGRectMake(0, 0, 35, 35);
    self.gifView.center = CGPointMake(react.size.width/2, react.size.height/2);
}

- (void)refreshHeaderView_DIY:(LNRefreshComponent *)view state:(LNRefreshState)state {
    switch (state) {
        case LNRefreshState_Normal:
        case LNRefreshState_PullToRefresh:
            [self endRefreshAnimation_DIY:view];
            break;
        case LNRefreshState_WillRefresh: {
            NSMutableArray *idleImages = [NSMutableArray array];
            for (NSUInteger i = 0; i <= 11; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_release_%lu", (unsigned long)i]];
                [idleImages addObject:image];
            }
            self.gifView.animationImages = idleImages;
            self.gifView.animationDuration = 1.0;
            [self.gifView startAnimating];
        }
            break;
        case LNRefreshState_Refreshing:
            [self startRefreshAnimation_DIY:view];
            break;
        default:
            break;
    }
}

- (void)endRefreshAnimation_DIY:(LNRefreshComponent *)view {
    self.gifView.image = [UIImage imageNamed:@"refresh_pull_0"];
}

- (void)startRefreshAnimation_DIY:(LNRefreshComponent *)view {
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_loop_%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    self.gifView.animationImages = idleImages;
    self.gifView.animationDuration = 1.0;
    [self.gifView startAnimating];
}

- (void)refreshView_DIY:(LNRefreshComponent *)view progress:(CGFloat)progress {
    if (progress > 1.0) { return; }
    [self.gifView stopAnimating];
    NSUInteger index = 20 * progress;
    if (index >= self.gifViewImages.count) index = self.gifViewImages.count - 1;
    self.gifView.image = self.gifViewImages[index];
}

@end
