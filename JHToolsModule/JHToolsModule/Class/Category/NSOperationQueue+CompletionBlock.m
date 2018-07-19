//
//  NSOperationQueue+CompletionBlock.m
//  IKToolsModule
//
//  Created by HU on 2018/7/10.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "NSOperationQueue+CompletionBlock.h"
#import <objc/runtime.h>
#pragma mark - NSOperationQueueOperationCountObserver

@interface NSOperationQueueOperationCountObserver : NSObject

@property (nonatomic, strong, nullable) NSOperationQueueCompletionBlock completionBlock;

@end

@implementation NSOperationQueueOperationCountObserver

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"operationCount"]) {
        NSInteger operationCount = [change[NSKeyValueChangeNewKey] integerValue];
        if (operationCount == 0 && self.completionBlock) {
            self.completionBlock();
        }
    }
}

@end

@implementation NSOperationQueue (CompletionBlock)

#pragma mark Swizzle Dealloc

+ (void)load {
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}

- (void)swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.completionBlock) {
        [self removeObserver:self.observer forKeyPath:@"operationCount"];
    }
    [self swizzledDealloc];
}


#pragma mark operationCounterObserver

- (nonnull NSOperationQueueOperationCountObserver *)observer {
    NSOperationQueueOperationCountObserver *observer = objc_getAssociatedObject(self, "observer");
    if (!observer) {
        observer = [[NSOperationQueueOperationCountObserver alloc] init];
        objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return observer;
}


#pragma mark completionBlock

- (nullable NSOperationQueueCompletionBlock)completionBlock {
    return self.observer.completionBlock;
}

- (void)setCompletionBlock:(nullable NSOperationQueueCompletionBlock)completionBlock {
    if (completionBlock) {
        [self addObserver:self.observer forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew context:NULL];
    } else {
        [self removeObserver:self.observer forKeyPath:@"operationCount"];
    }
    self.observer.completionBlock = completionBlock;
}

@end
