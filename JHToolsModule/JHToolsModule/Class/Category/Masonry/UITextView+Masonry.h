//
//  UITextView+Masonry.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMasonryTool.h"
@interface UITextView (Masonry)
/**
 * 快速创建一个UItextView,设置字体大小，字体颜色，placeText,placeColor，masonry布局
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param placeColor placeText
 @param placeText placeColor
 @param constraints masonry布局
 @param superView 父视图
 @return textView
 */
+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;


/**
 * 快速创建一个UItextView,设置字体大小，字体颜色，边框颜色，边框大小，圆角，placeText,placeColor，masonry布局
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param borderColor 边框颜色
 @param borderWidth 边框大小
 @param cornerRadiu 圆角
 @param placeColor placeText
 @param placeText placeColor
 @param constraints masonry布局
 @param superView 父视图
 @return textView
 */
+(instancetype)masTextViewWithFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                           borderColor:(UIColor *)borderColor
                           borderWidth:(CGFloat)borderWidth
                           cornerRadiu:(CGFloat)cornerRadiu
                            placeColor:(UIColor *)placeColor
                             placeText:(NSString *)placeText
                             superView:(UIView *)superView
                           constraints:(JHConstrainMaker)constraints;

- (void)masTextViewsSetPlaceholderWithText:(NSString *)text Color:(UIColor *)color;
@end
