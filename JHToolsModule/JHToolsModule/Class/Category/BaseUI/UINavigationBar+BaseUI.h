//
//  UINavigationBar+BaseUI.h
//  IKToolsModule
//
//  Created by HU on 2018/7/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BaseUI)
- (void)baseSetBackgroundColor:(UIColor *)backgroundColor;
- (void)baseSetElementsAlpha:(CGFloat)alpha;
- (void)baseSetTranslationY:(CGFloat)translationY;
- (void)baseReset;
@end
