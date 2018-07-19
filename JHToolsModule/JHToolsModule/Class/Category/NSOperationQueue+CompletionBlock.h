//
//  NSOperationQueue+CompletionBlock.h
//  IKToolsModule
//
//  Created by HU on 2018/7/10.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT double NSOperationQueue_CompletionBlockVersionNumber;
FOUNDATION_EXPORT const unsigned char NSOperationQueue_CompletionBlockVersionString[];
typedef void (^NSOperationQueueCompletionBlock)(void);

@interface NSOperationQueue (CompletionBlock)
@property (nonatomic, strong, nullable) NSOperationQueueCompletionBlock completionBlock;
@end

NS_ASSUME_NONNULL_END
