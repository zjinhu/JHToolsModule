//
//  UIButton+DelayEvent.m
//  IKToolsModule
//
//  Created by HU on 2018/7/11.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UIButton+DelayEvent.h"
#import <objc/runtime.h>
@interface UIButton ()
/// 是否忽略点击事件；YES，忽略点击事件，NO，允许点击事件
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end

@implementation UIButton (DelayEvent)

static const CGFloat EventDefaultTimeInterval = 0;

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, @"isIgnoreEvent") boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, @"isIgnoreEvent", @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)eventTimeInterval {
    return [objc_getAssociatedObject(self, @"eventTimeInterval") doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval {
    objc_setAssociatedObject(self, @"eventTimeInterval", @(eventTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSEL = @selector(sendAction:to:forEvent:);
        SEL replaceSEL = @selector(IK_sendAction:to:forEvent:);
        Method systemMethod = class_getInstanceMethod(self, systemSEL);
        Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
        
        BOOL isAdd = class_addMethod(self, systemSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
        
        if (isAdd) {
            class_replaceMethod(self, replaceSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            // 添加失败，说明本类中有 replaceMethod 的实现，此时只需要将 systemMethod 和 replaceMethod 的IMP互换一下即可
            method_exchangeImplementations(systemMethod, replaceMethod);
        }
    });
}

- (void)IK_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    self.eventTimeInterval = self.eventTimeInterval == 0 ? EventDefaultTimeInterval : self.eventTimeInterval;
    if (self.isIgnoreEvent){
        return;
    } else if (self.eventTimeInterval >= 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
        });
    }
    self.isIgnoreEvent = YES;
    [self IK_sendAction:action to:target forEvent:event];
}

@end
