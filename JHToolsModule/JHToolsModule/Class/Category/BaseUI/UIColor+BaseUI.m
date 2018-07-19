//
//  UIColor+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIColor+BaseUI.h"
#import "NSString+Base.h"
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


+(UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}
+ (instancetype)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}
static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrim] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}
static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}
@end
