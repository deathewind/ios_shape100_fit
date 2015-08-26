//
//  MLNavigationController.h
//  iosClassTool
//
//  Created by 张明磊 on 14-4-3.
//  Copyright (c) 2014年 张明磊. All rights reserved.

#import <UIKit/UIKit.h>

@interface MLNavigationController : UINavigationController <UIGestureRecognizerDelegate>

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated canDragBack:(BOOL)can;
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated canDragBack:(BOOL)can;
@end
