//
//  UIColor+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIColor+BaseUI.h"

@implementation UIColor (BaseUI)
///////////////////////////////////////////主色///////////////////////////////////////////////
#pragma 主色区
+ (UIColor *)baseColor{
    return [UIColor colorWithHex:0xea5504 alpha:1.0];
}

+ (UIColor *)baseYellowColor{
    return [UIColor colorWithHex:0xFFA00A alpha:1.0];
}

+ (UIColor *)baseOrangeColor{
    return [UIColor colorWithHex:0xFC7D3D alpha:1.0];
}
///////////////////////////////////////////辅色///////////////////////////////////////////////
#pragma 辅色区
+ (UIColor *)baseBlueColor{
    return [UIColor colorWithHex:0x51a9e2 alpha:1.0];
}

+ (UIColor *)baseBlueSecondColor{
    return [UIColor colorWithHex:0x09c199 alpha:1.0];
}

+ (UIColor *)baseBlueGreenColor{
    return [UIColor colorWithHex:0x589daf alpha:1.0];
}

+ (UIColor *)baseBlueDownColor{
    return [UIColor colorWithHex:0x0080ff alpha:0.5];
}

+ (UIColor *)baseGreenColor{
    return [UIColor colorWithHex:0x3dbd7d alpha:1.0];
}

+ (UIColor *)baseRedColor{
    return [UIColor colorWithHex:0xF26363 alpha:1.0];
}

///////////////////////////////////////////文字///////////////////////////////////////////////
#pragma 文字颜色区
+ (UIColor *)baseTextColor{
    return [UIColor colorWithHex:0x333333 alpha:1.0];
}

+ (UIColor *)baseGraySixColor{
    return [UIColor colorWithHex:0x666666 alpha:1.0];
}

+ (UIColor *)baseTextMainColor{
    return [UIColor colorWithHex:0x363636 alpha:1.0];
}

+ (UIColor *)baseTextDetailColor{
    return [UIColor colorWithHex:0x878787 alpha:1.0];
}

+ (UIColor *)baseTextGrayColor{
    return [UIColor colorWithHex:0x808080 alpha:1.0];
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

+ (UIColor *)baseTextHighLightOrangeColor{
    return [UIColor colorWithHex:0xfbc095 alpha:1.0];
}

///////////////////////////////////////////其他///////////////////////////////////////////////
#pragma 其他颜色区
+ (UIColor *)baseTipsColor{
    return [UIColor colorWithHex:0xfff8ea alpha:1.0];
}

+ (UIColor *)baseLineColor{
    return [UIColor colorWithHex:0xe3e3e3 alpha:1.0];
}

+ (UIColor *)baseBackgroundColor{
    return [UIColor colorWithHex:0xf5f5f5 alpha:1.0];
}

+ (UIColor *)baseWhiteColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:1.0];
}

+ (UIColor *)baseWhiteDownColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:0.5];
}

+ (UIColor *)baseNaviBackGroundColor{
    return [UIColor colorWithHex:0xfafafa alpha:1.0];
}

+ (UIColor *)baseNaviShadowColor{
    return [UIColor colorWithHex:0xcdcdcd alpha:1.0];
}

+ (UIColor *)cellHighLightColor{
    return [UIColor colorWithHex:0xeaeaea alpha:1.0];
}

////////////////////////////////////////颜色工具///////////////////////////////////////////////
#pragma 颜色工具
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *removeSharpMarkhexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:removeSharpMarkhexString];
    unsigned result = 0;
    [scanner scanHexInt:&result];
    return [self.class colorWithHex:result];
}

+ (UIColor *)colorWithHex:(NSInteger)hexColor{
    return [self colorWithHex:hexColor alpha:1.0];
}

/**
 *  获取图片的主色
 *
 *  @param image image
 *  @param scale 精准度0.1~1
 *
 *  @return 图片的主要颜色
 */
+ (UIColor *)mostColor:(UIImage *)image scale:(CGFloat)scale{


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    if (scale <= 0.1) {
        scale = 0.1;
    }else if(scale >= 1){
        scale = 1;
    }

    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
        CGSize thumbSize=CGSizeMake([image size].width * scale, [image size].height * scale);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);

    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);



    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);

    if (data == NULL){
        CGContextRelease(context);
        return nil;
    }

    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

  for (int x=0; x<thumbSize.height; x++) {
        for (int y=0; y<thumbSize.width; y++) {

            int offset = 4*(x*thumbSize.width + y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];

            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];

        }
    }
    CGContextRelease(context);


    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;

    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;

    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];

        if ( tmpCount < MaxCount ) continue;

        MaxCount=tmpCount;
        MaxColor=curColor;

    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}
@end
