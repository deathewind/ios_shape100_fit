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
#import "ButtonDoctView.h"
//#import "CExpandHeader.h"

@interface YXProductDetailViewController()<ButtonDoctViewDelegate, YXLoadingViewDelegate, UITableViewDataSource,UITableViewDelegate>
{
    YXLoadingView *CoverView;
    NSString      *product_id;
   // CExpandHeader *_header;
    UILabel       *_moneyLabel;
}
//@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) CountView *countView;
@property(nonatomic, strong) CourseHeaderView  *imageView;
@property(nonatomic, strong) UILabel *describe;
@property(nonatomic, strong) ButtonDoctView *buttonView;
@property(nonatomic, strong) NSString *counts;
//@property (nonatomic, strong) YXBGScrollowView *bgView;
@property(nonatomic, weak) UIButton *button;
@property(nonatomic, strong) UITableView *tableView;
@end
@implementation YXProductDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  //  self.navBar.hidden = YES;
   // self.navBar.alpha = 0;
    self.titleBar.text = self.product.product_name;
  //  [self.view addSubview:self.bgView];
    [self.view insertSubview:self.tableView belowSubview:self.navBar];
    [self creatBackButton];
    [self addBuyButton];
    [self addCoverView];
    [self loadProductData];
    _counts = @"1";
    
}
//- (YXBGScrollowView *)bgView{
//    if (!_bgView) {
//        _bgView = [[YXBGScrollowView alloc] initWithFrame:self.view.frame];
//        _bgView.delegate = self;
//    }
//    return _bgView;
//}
//
//- (void)detailsForegroundView:(UIView *)foregroundView{
//    
//    [foregroundView addSubview:self.tableView];
//    
//}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, self.view.width, self.view.height - 44 - self.navBar.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(230, 230, 230);
        _tableView.tableHeaderView = self.imageView;
     //   _tableView.backgroundColor = [UIColor clearColor];
        //   [self.view addSubview:_tableView];
        
//        void *context = (__bridge void *)self;
//        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
    }
    return _tableView;
}
//- (void)dealloc
//{
//    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    // Make sure we are observing this value.
//    if (context != (__bridge void *)self) {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        return;
//    }
//    
//    if ((object == self.tableView) &&
//        ([keyPath isEqualToString:@"contentOffset"] == YES))
//    {
//        [self scrollViewDidScrollWithOffset:self.tableView.contentOffset.y];
//        return;
//    }
//}
#pragma mark ScrollView Methods

//- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
//{
//    
//    CGFloat a = (scrollOffset + 220)/150;
//    if (1 >= a > 0) {
//        self.navBar.alpha = a;
//        if (a>0.9) {
//            _button.backgroundColor = [UIColor clearColor];
//        }
//        NSLog(@"scrollOffset = %f", a );
//        if (a == 0) {
//            _button.backgroundColor = RGBA(40, 40, 40, 0.3);
//        }
//    }
//    
////    if(scrollOffset > 100 && self.navBar.alpha == 0.0)
////    { //make the navbar appear
////       // CGFloat a = (scrollOffset - 100)/120;
////        self.navBar.alpha = 0;
////        self.navBar.hidden = NO;
////        [UIView animateWithDuration:0.5 animations:^
////         {
////             self.navBar.alpha = 1;
////         }];
////    }
////    else if(scrollOffset < 100 && self.navBar.alpha == 1.0)
////    { //make the navbar disappear
////       // self.navBar.alpha = scrollOffset/180;
////        [UIView animateWithDuration:0.5 animations:^{
////            self.navBar.alpha = 0;
////        } completion: ^(BOOL finished) {
////            self.navBar.hidden = YES;
////        }];
////    }
//}

- (void)loadProductData{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    [[YXNetworkingTool sharedInstance] getProductDetailWithID:self.product.product_id success:^(id JSON) {
        [UIView animateWithDuration:0.4 animations:^{
            CoverView.alpha = 0.;
        } completion:^(BOOL finished) {
            [CoverView removeFromSuperview];
        }];
        [UIUtils hideProgressHUD:self.view];
        
        Model_product *product = [Model_product productWithDictionary:JSON];
        [self.imageView setProduct:product];
       // _header = [CExpandHeader expandWithScrollView:self.tableView expandView:self.imageView];
//        self.countView.maxCount = product.product_num;
        self.describe.text = product.product_description;
//
        _moneyLabel.text = [NSString stringWithFormat:@"应付总额: ￥%@", product.product_price];
        product_id = [NSString stringWithFormat:@"%@", product.product_id];
       // [self.tableView reloadData];
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [CoverView showFailure];
    }];
    
}
- (void)addCoverView{
    CoverView  = [[YXLoadingView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight -  self.navBar.height) color:[UIColor whiteColor]];
    CoverView.delegate = self;
    [self.view addSubview:CoverView];
}
- (void)retryRequest{
    [self loadProductData];
}

- (ButtonDoctView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[ButtonDoctView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , 44)];
        _buttonView.delegate = self;
    }
    return _buttonView;
}
- (void)clickChangeView:(UIButton *)button{
    
}
- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , 300)];
        _describe.numberOfLines = 0;
        _describe.font = YXCharacterFont(15);
        _describe.backgroundColor = RGB(230, 230, 230);
        // _describe.text = self.product.product_description;
    }
    return _describe;
}
- (CountView *)countView{
    if (!_countView) {
        _countView = [[CountView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        __weak UILabel *labe = _moneyLabel;
        _countView.countChange = ^(NSString *count){
           // YXLog(@"%@", count);
            _counts = count;
            labe.text = [NSString stringWithFormat:@"应付总额: ￥%d", [self.product.product_price intValue] * [count intValue]];
        };
    }
    return _countView;
}
- (CourseHeaderView *)imageView{
    if (!_imageView) {
        _imageView = [[CourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
        // [_imageView setProduct:self.product];
        
    }
    return _imageView;
}



- (void)addBuyButton{
    UIView *but = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    but.backgroundColor = RGB(60, 60, 60);
    [self.view addSubview:but];
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.width - 10, but.height)];
    _moneyLabel.textColor = [UIColor redColor];
    [but addSubview:_moneyLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenWidth - 120, 0, 120, but.height);
    [button setTitle:@"购买课程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = YXCharacterFont(16);
    [but addSubview:button];
}

- (void)pay{
#pragma mark 网络错误时 self.product.product_id 没有
   // NSString *productID = [NSString stringWithFormat:@"%@", self.product.product_id];
    if (product_id) {
        [UIUtils showProgressHUDto:self.view withString:@"创建订单中" showTime:60];
        [[YXNetworkingTool sharedInstance] createOrderWithProduct:product_id count:_counts success:^(id JSON) {
            [UIUtils hideProgressHUD:self.view];
            
            Model_order *order = [Model_order orderWithDictionary:JSON];
            YXPayViewController *pay = [[YXPayViewController alloc] init];
            pay.order = order;
            [self pushViewController:pay];
        } failure:^(NSError *error, id JSON) {
            [UIUtils hideProgressHUD:self.view];
        }];
    }

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        static NSString *CellIdentifier = @"MainCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.countView];
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.describe];
        }
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    return 300;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.buttonView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.1;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.1;
}
@end
