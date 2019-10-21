//
//  UIImageView+LoadURL.m
//  IKToolsModule
//
//  Created by HU on 2018/8/3.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIImageView+LoadURL.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+BaseUI.h"
@implementation UIImageView (LoadURL)
 
- (void)imageWithURL:(NSString*)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)imageWithPlaceHolder:(NSString*)imageName
                    imageURL:(NSString*)imageURL {
     [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:imageName]];
}
- (void)imageCenterPlaceHolder:(UIImage*)imagePlaceHolder
                      imageURL:(NSString*)imageURL {
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageCenterPlaceHolder:imagePlaceHolder toSize:self.frame.size]];
}

@end
