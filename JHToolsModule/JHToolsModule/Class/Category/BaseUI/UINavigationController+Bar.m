//
//  UINavigationController+Bar.m
//  JHToolsModule
//
//  Created by iOS on 11/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

#import "UINavigationController+Bar.h"

#import <objc/runtime.h>
typedef void(^_JHViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (HandlerNavigationBarPrivate)

@property(nonatomic, copy) _JHViewControllerWillAppearInjectBlock jh_willAppearInjectBlock;

@end

// MARK: - 替换UIViewController的viewWillAppear方法，在此方法中，执行设置导航栏隐藏和显示的代码块。
@implementation UIViewController (HandlerNavigationBarPrivate)

+ (void)load
{
    Method orginalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(jh_viewWillAppear:));
    method_exchangeImplementations(orginalMethod, swizzledMethod);
}

- (void)jh_viewWillAppear:(BOOL)animated
{
    [self jh_viewWillAppear:animated];

    if (self.jh_willAppearInjectBlock) {
        self.jh_willAppearInjectBlock(self, animated);
    }
}

- (_JHViewControllerWillAppearInjectBlock)jh_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJh_willAppearInjectBlock:(_JHViewControllerWillAppearInjectBlock)block
{
    objc_setAssociatedObject(self, @selector(jh_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

// MARK: - 给UIViewController添加lsl_prefersNavigationBarHidden属性

@implementation UIViewController (HandlerNavigationBar)

- (BOOL)jh_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setJh_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(jh_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
// MARK: - 替换UINavigationController的pushViewController:animated:方法，在此方法中去设置导航栏的隐藏和显示
@implementation UINavigationController (Bar)
+ (void)load
{
    Method originMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzedMethod = class_getInstanceMethod(self, @selector(jh_pushViewController:animated:));
    method_exchangeImplementations(originMethod, swizzedMethod);

    Method originSetViewControllersMethod = class_getInstanceMethod(self, @selector(setViewControllers:animated:));
    Method swizzedSetViewControllersMethod = class_getInstanceMethod(self, @selector(jh_setViewControllers:animated:));
    method_exchangeImplementations(originSetViewControllersMethod, swizzedSetViewControllersMethod);
}

- (void)jh_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Handle perferred navigation bar appearance.
    [self jh_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];

    // Forward to primary implementation.
    [self jh_pushViewController:viewController animated:animated];
}

- (void)jh_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    // Handle perferred navigation bar appearance.
    for (UIViewController *viewController in viewControllers) {
        [self jh_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    }

    // Forward to primary implementation.
    [self jh_setViewControllers:viewControllers animated:animated];
}

- (void)jh_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.jh_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }

    // 即将被调用的代码块
    __weak typeof(self) weakSelf = self;
    _JHViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.jh_prefersNavigationBarHidden animated:animated];
        }
    };

    // 给即将显示的控制器，注入代码块
    appearingViewController.jh_willAppearInjectBlock = block;

    // 因为不是所有的都是通过push的方式，把控制器压入stack中，也可能是"-setViewControllers:"的方式，所以需要对栈顶控制器做下判断并赋值。
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.jh_willAppearInjectBlock) {
        disappearingViewController.jh_willAppearInjectBlock = block;
    }
}

- (BOOL)jh_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.jh_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setJh_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(jh_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
