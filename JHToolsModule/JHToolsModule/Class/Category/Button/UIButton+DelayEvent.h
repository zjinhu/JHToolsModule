//
//  UIButton+DelayEvent.h
//  IKToolsModule
//
//  Created by HU on 2018/7/11.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DelayEvent)
/** 按钮事件响应间隔 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end

NS_ASSUME_NONNULL_END
