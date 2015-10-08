//
//  UIViewController+AOPViewController.m
//  YXFit
//
//  Created by 何军 on 24/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIViewController+AOPViewController.h"
#import <objc/runtime.h>
@implementation UIViewController (AOPViewController)
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
//        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
//        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
//        swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
//    });
//}
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (void)aop_viewDidLoad{
    [self aop_viewDidLoad];
   // Class class = [self class];
   // NSLog(@"class = %@", NSSelectorFromString(class));
/*
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        nav.navigationBar.translucent = NO;
        nav.navigationBar.barTintColor = [UIColor blackColor];
        nav.navigationBar.tintColor = [UIColor whiteColor];
        NSDictionary *titleAtt = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [[UINavigationBar appearance] setTitleTextAttributes:titleAtt];
        [[UIBarButtonItem appearance]
         setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
         forBarMetrics:UIBarMetricsDefault];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
*/
}
- (void)aop_viewDidAppear:(BOOL)animated{
    [self aop_viewDidAppear:animated];
    NSLog(@"viewDidAppear: %@", self);
}
- (void)aop_viewWillAppear:(BOOL)animated{
    [self aop_viewWillAppear:animated];
    //dosomeing, for example
    //#ifndef DEBUG
    //    [MobClick beginLogPageView:NSStringFromClass([self class])];
    //#endif
}

- (void)aop_viewWillDisappear:(BOOL)animated{
    [self aop_viewWillDisappear:animated];
    //dosomeing, for example
    //#ifndef DEBUG
    //    [MobClick endLogPageView:NSStringFromClass([self class])];
    //#endif
}
@end
