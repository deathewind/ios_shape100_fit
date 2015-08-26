//
//  YXProductDetailViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXProductDetailViewController.h"
#import "YXPayViewController.h"
#import "CourseHeaderView.h"
#import "CountView.h"
#import "DescribeView.h"
@interface YXProductDetailViewController()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) CountView *countView;
@property(nonatomic, strong) CourseHeaderView  *imageView;
@property(nonatomic, strong) UILabel *describe;

@property(nonatomic, strong) NSString *counts;
@end
@implementation YXProductDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleBar.text = self.product.product_name;
    [self.view addSubview:self.scrollView];
    [self loadProductData];
    [self addBackButton];
    _counts = @"1";
    
}
- (void)loadProductData{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    [[YXNetworkingTool sharedInstance] getProductDetailWithID:self.product.product_id success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        Model_product *product = [Model_product productWithDictionary:JSON];
        [self.imageView setProduct:product];
        self.describe.text = product.product_description;
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
    }];
    
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight -  self.navBar.height)];
        _scrollView.backgroundColor = RGB(233, 233, 233);
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        [_scrollView addSubview:self.imageView];
        [_scrollView addSubview:self.countView];
        [_scrollView addSubview:self.describe];
    }
    return _scrollView;
}
- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc] initWithFrame:CGRectMake(10, self.countView.height + self.countView.origin.y + 10, _scrollView.width - 10 * 2, 100)];
        _describe.numberOfLines = 0;
        _describe.font = YXCharacterFont(15);
        // _describe.text = self.product.product_description;
    }
    return _describe;
}
- (CountView *)countView{
    if (!_countView) {
        _countView = [[CountView alloc] initWithFrame:CGRectMake(10, self.imageView.height + 10, _scrollView.width - 10 * 2, 50)];
        
        _countView.countChange = ^(NSString *count){
            YXLog(@"%@", count);
            _counts = count;
        };
    }
    return _countView;
}
- (CourseHeaderView *)imageView{
    if (!_imageView) {
        _imageView = [[CourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, 200)];
        // [_imageView setProduct:self.product];
        
    }
    return _imageView;
}
- (void)addBackButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, 20, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50); 
    [button setTitle:@"立即购买" forState:UIControlStateNormal];
    button.backgroundColor = RGB(156, 210, 122);
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pay{
    NSString *productID = [NSString stringWithFormat:@"%@", self.product.product_id];
    [UIUtils showProgressHUDto:self.view withString:@"创建订单中" showTime:60];
    [[YXNetworkingTool sharedInstance] createOrderWithProduct:productID count:_counts success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        
        Model_order *order = [Model_order orderWithDictionary:JSON];
        YXPayViewController *pay = [[YXPayViewController alloc] init];
        pay.order = order;
        [self pushViewController:pay];
        NSLog(@"JSON = %@", JSON);
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        NSLog(@"error = %@", error);
    }];
    
}

@end
