//
//  BaseViewController.m
//  YXFit
//
//  Created by 何军 on 15/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BaseViewController.h"
#import "MLNavigationController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
            [self setNeedsStatusBarAppearanceUpdate];
            self.automaticallyAdjustsScrollViewInsets = NO;
            
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
            
        }
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *imageView_title = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,64)];
    imageView_title.backgroundColor = RGB(156, 210, 120);
   // imageView_title.backgroundColor = [UIColor orangeColor];
    self.navBar = imageView_title;
    [self.view addSubview:imageView_title];
    
    UILabel *label_title = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, self.view.width - 60 * 2, 44)];
    label_title.backgroundColor = [UIColor clearColor];
    label_title.textColor = [UIColor whiteColor];
    label_title.textAlignment = NSTextAlignmentCenter;
    label_title.font = YXCharacterBoldFont(18);
    self.titleBar = label_title;
    [imageView_title addSubview:label_title];
}

- (void)pushViewController:(BaseViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
//    viewController.navigationController_ML = _navigationController_ML;
//    [self.navigationController_ML pushViewController:viewController animated:YES];
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
   // [self.navigationController_ML popViewControllerAnimated:YES];
}

- (void)clickButton_back{
    [self.navigationController popViewControllerAnimated:YES];
  //  [self.navigationController_ML popViewControllerAnimated:YES];
}
@end
