//
//  UIFont+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (BaseUI)
//基础字体大小
+ (UIFont *)baseFont;

//默认小号字体
+ (UIFont *)smallFont;

//默认大号字体
+ (UIFont *)bigFont;

//标题字号
+ (UIFont *)menuFont;

//cell常用字号
+ (UIFont *)cellFont;
@end
