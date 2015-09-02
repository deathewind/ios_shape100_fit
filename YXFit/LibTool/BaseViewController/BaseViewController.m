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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *imageView_title = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,64)];
   // imageView_title.backgroundColor = RGB(156, 210, 120);
   // imageView_title.backgroundColor = [UIColor orangeColor];
    imageView_title.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, imageView_title.height - 0.5, imageView_title.width, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [imageView_title addSubview:line];
    self.navBar = imageView_title;
    [self.view addSubview:imageView_title];
    
    UILabel *label_title = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, self.view.width - 60 * 2, 44)];
    label_title.backgroundColor = [UIColor clearColor];
   // label_title.textColor = [UIColor whiteColor];
    label_title.textColor = RGB(60, 60, 60);
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

- (void)creatBackButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    //  button_back.backgroundColor = RGBA(40, 40, 40, 0.3);
    [button_back setImage:[UIImage imageFileName:@"cd_backBlack.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    // _button = button_back;
    //  button_back.layer.cornerRadius = 10;
    [self.view addSubview:button_back];
}

- (void)clickButton_back{
    [self.navigationController popViewControllerAnimated:YES];
  //  [self.navigationController_ML popViewControllerAnimated:YES];
}
@end
