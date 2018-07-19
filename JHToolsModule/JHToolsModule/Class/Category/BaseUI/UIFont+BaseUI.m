//
//  UIFont+BaseUI.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIFont+BaseUI.h"

@implementation UIFont (BaseUI)
+ (UIFont *)smallFont{
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)cellFont{
    return [UIFont systemFontOfSize:14];
}

+ (UIFont *)baseFont{
    return [UIFont systemFontOfSize:15];
}

+ (UIFont *)menuFont{
    return [UIFont systemFontOfSize:16];
}

+ (UIFont *)bigFont{
    return [UIFont systemFontOfSize:17];
}
@end
