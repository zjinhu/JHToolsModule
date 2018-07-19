//
//  NSString+Base.m
//  IKToolsModule
//
//  Created by HU on 2018/6/5.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "NSString+Base.h"

#import <CoreText/CoreText.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Base)
- (NSString *)getMD5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString  stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]
            ];
}
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

- (CGSize)getSizeWithFont:(UIFont *)font{
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:attributes];
    
}

- (CGSize)getSizeWithAtt:(NSDictionary *)att ConstrainedToSize:(CGSize)size{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:att context:nil].size;
}
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndLineHeight:(CGFloat)lineHeight{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineHeight];
    NSDictionary * attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size AndParagraphStyle:(NSParagraphStyle *)paragraphStyle{
    NSDictionary * attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
}

@end
