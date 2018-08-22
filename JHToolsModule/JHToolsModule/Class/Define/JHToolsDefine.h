//
//  JHToolsDefine.h
//  JHToolsModule
//
//  Created by HU on 2018/7/18.
//  Copyright © 2018年 HU. All rights reserved.
//

#ifndef JHToolsDefine_h
#define JHToolsDefine_h

#import <Masonry/Masonry.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

//weak
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//图片
#define ImageNamed(NAME)  ([UIImage imageNamed:NAME])
//比例线
#define Scare       [[UIScreen mainScreen] scale]
#define LineHeight  (Scare >= 1 ? 1/Scare : 1)
//字体
#define FontOfMedium(sizeint)   [UIFont systemFontOfSize:sizeint weight:UIFontWeightMedium]
#define FontOfSemibold(sizeint) [UIFont systemFontOfSize:sizeint weight:UIFontWeightSemibold]
#define Font(sizeint)           [UIFont systemFontOfSize:sizeint]
///颜色
#define CLEARCOLOR [UIColor clearColor]

#define UIColorFromName(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define ColorOfRandom random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 判断是否是iPhone X
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)

#define NAVIGATION_BAR_HEIGHT_NORMAL (iPhoneX ? 68.f : 44.f)

// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

//屏幕尺寸
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define FIT_WIDTH  (SCREEN_WIDTH/375)
#define FIT_HEIGHT  (SCREEN_HEIGHT/667)

//系统版本
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IOS10_OR_BEFORE ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IOS12_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)
//单例封装(用法.h SingletonH(A); .m SingletonM(A);  类: [x shareA])
#define SingletonH(name)  + (instancetype)share##name;

#define SingletonM(name) static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;}\
+ (instancetype)share##name { return [[self alloc] init]; }\
- (id)copyWithZone:(NSZone *)zone { return _instance; }\
- (id)mutableCopyWithZone:(NSZone *)zone { return _instance; }
///LOG
#ifdef DEBUG
#define NSLog(format, ...) printf("\n\n↓↓↓↓↓↓↓↓↓↓↓↓[Log]↓↓↓↓↓↓↓↓↓↓↓↓\n>>>>>>>>>>>>>位置<<<<<<<<<<<<<\n%s\n>>>>>>>>>>>>>方法<<<<<<<<<<<<<\n%s\n>>>>>>>>>>>>>行数<<<<<<<<<<<<<\n第%d行\n>>>>>>>>>>>>>信息<<<<<<<<<<<<<\n%s\n↑↑↑↑↑↑↑↑↑↑↑↑[END]↑↑↑↑↑↑↑↑↑↑↑↑\n\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define NSLog(...)
#endif
#endif /* JHToolsDefine_h */
