//
//  BaseViewController.h
//  YXFit
//
//  Created by 何军 on 15/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class MLNavigationController;
@interface BaseViewController : UIViewController
//@property (weak ,nonatomic) MLNavigationController *navigationController_ML;
@property (weak, nonatomic) UILabel *titleBar;
@property (weak, nonatomic) UIView  *navBar;

- (void)pushViewController:(BaseViewController *)viewController;

- (void)popViewController;

- (void)clickButton_back;
@end
