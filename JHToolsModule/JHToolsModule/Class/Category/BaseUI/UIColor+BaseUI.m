//
//  UIColor+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIColor+BaseUI.h"

@implementation UIColor (BaseUI)
+ (UIColor *)baseColor
{
    return [UIColor colorWithHex:0xea5504 alpha:1.0];
}
+ (UIColor *)baseLineColor{
    return [UIColor colorWithHex:0xCED3D9 alpha:1.0];
}

+ (UIColor *)baseBackgroundColor{
    return [UIColor colorWithHex:0xf5f5f5 alpha:1.0];
}

+ (UIColor *)baseTextColor{
    return [UIColor colorWithHex:0x18191a alpha:1.0];
}

+ (UIColor *)baseTextGrayColor{
    return [UIColor colorWithHex:0x919599 alpha:1.0];
}
+ (UIColor *)baseTextDisEnableColor{
    return [UIColor colorWithHex:0xdae0e6 alpha:1.0];
}
+ (UIColor *)baseTextGrayNonColor{
    return [UIColor colorWithHex:0xcccccc alpha:1.0];
}
+ (UIColor *)baseTileBlueColor{
    return [UIColor colorWithHex:0x0080ff alpha:1.0];
}
+ (UIColor *)baseBlueColor{
    return [UIColor colorWithHex:0x3674b3 alpha:1.0];
}

+ (UIColor *)baseBlueDownColor{
    return [UIColor colorWithHex:0x0080ff alpha:0.5];
}

+ (UIColor *)baseGreenColor
{
    return [UIColor colorWithHex:0x14cc55 alpha:1.0];
}

+ (UIColor *)baseYellowColor{
    return [UIColor colorWithHex:0xFF8500 alpha:1.0];
}

+ (UIColor *)baseRedColor{
    return [UIColor colorWithHex:0xF23D4C alpha:1.0];
}


+ (UIColor *)baseWhiteColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:1.0];
}

+ (UIColor *)baseWhiteDownColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:0.5];
}




+ (UIColor *)baseNaviBackGroundColor{
    return [UIColor colorWithHex:0xf4f4f4 alpha:1.0];
}



+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor *)baseNaviShadowColor{
    return [UIColor colorWithHex:0xcdcdcd alpha:1.0];
}

+ (UIColor *)baseTextHighLightOrangeColor{
    return [UIColor colorWithHex:0xfbc095 alpha:1.0];
}

+ (UIColor *)cellHighLightColor{
    return [UIColor colorWithHex:0xeaeaea alpha:1.0];
}
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
