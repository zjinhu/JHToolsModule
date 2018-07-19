//
//  NSString+Base.h
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Base)
- (NSString *)getMD5;
- (NSString *)stringByTrim;


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)getSizeWithFont:(UIFont *)font;

- (CGSize)getSizeWithAtt:(NSDictionary *)att ConstrainedToSize:(CGSize)size;
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndLineHeight:(CGFloat)lineHeight;
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndParagraphStyle:(NSParagraphStyle *)paragraphStyle;
@end
