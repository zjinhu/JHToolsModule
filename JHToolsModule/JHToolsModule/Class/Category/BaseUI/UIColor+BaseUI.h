//
//  UIColor+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BaseUI)
+ (UIColor *)baseWhiteColor;
+ (UIColor *)baseWhiteDownColor;
//APP主色调 ColorOrange
+ (UIColor *)baseColor;
//基础黄色 Yellow
+ (UIColor *)baseYellowColor;
//基础蓝色 Bule
+ (UIColor *)baseTileBlueColor;
+ (UIColor *)baseBlueColor;
//基础绿色 Green
+ (UIColor *)baseGreenColor;
//基础蓝色 按下
+ (UIColor *)baseBlueDownColor;
//基础文本颜色  Black
+ (UIColor *)baseTextColor;
//基础文本置灰 Gray-1
+ (UIColor *)baseTextDisEnableColor;
+ (UIColor *)baseTextGrayColor;
//基础文本置灰 不可点击 Gray-2
+ (UIColor *)baseTextGrayNonColor;
//基础红色
+ (UIColor *)baseRedColor;
//基础线条颜色
+ (UIColor *)baseLineColor;
//基础背景颜色
+ (UIColor *)baseBackgroundColor;

+ (UIColor *)cellHighLightColor;

//16进制色值转换
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;

+(UIColor *) colorFromHexRGB:(NSString *) inColorString;

+ (UIColor *)colorWithHexString:(NSString *)hexStr;
@end
