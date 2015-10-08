//
//  YXProductDetailViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXProductDetailViewController.h"

#import "CountView.h"
#import "DescribeView.h"
#import "ButtonDoctView.h"
//#import "CExpandHeader.h"
#import "ExpandTableViewHeader.h"
#import "YXCalendarViewController.h"


#import "YXPayInfoViewController.h"
@interface YXProductDetailViewController()<ButtonDoctViewDelegate, YXLoadingViewDelegate, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    YXLoadingView *CoverView;
    NSString      *product_id;
    UILabel       *_moneyLabel;
}

@property(nonatomic, strong) CountView *countView;
@property(nonatomic, strong) UILabel *describe;
@property(nonatomic, strong) ButtonDoctView *buttonView;
@property(nonatomic, strong) NSString *counts;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ExpandTableViewHeader *headerView;

@property(nonatomic, strong) UILabel *label; //日期时间标签


@property(nonatomic, strong) NSIndexPath *indexPa; //记录日期选择的位置

@end
@implementation YXProductDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = self.product.product_name;
    [self.view insertSubview:self.tableView belowSubview:self.navBar];
    [self creatBackButton];
    [self addBuyButton];
    [self addCoverView];
    [self loadProductData];
    _counts = @"1";
}

- (ExpandTableViewHeader *)headerView{
    if (!_headerView) {
        _headerView = [[ExpandTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerViewHeight)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        void *context = (__bridge void *)self;
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
    }
    return _tableView;
}
- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Make sure we are observing this value.
    if (context != (__bridge void *)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ((object == self.tableView) &&
        ([keyPath isEqualToString:@"contentOffset"] == YES))
    {
        [self scrollViewDidScrollWithOffset:self.tableView.contentOffset.y];
        return;
    }
}
#pragma mark ScrollView Methods

- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
{
//    NSLog(@"scrollOffset = %f", scrollOffset);
    if ((headerViewHeight - 64)>=scrollOffset>0) {
        CGFloat a = scrollOffset/(headerViewHeight - 64);
        if (a > 0.9 && a != 0.9) {
            a = 0.9;
        }
        self.navBar.alpha = a;
    }

}

- (void)loadProductData{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    [[YXNetworkingTool sharedInstance] getProductDetailWithID:self.product.product_id success:^(id JSON) {
        [UIView animateWithDuration:0.4 animations:^{
            self.navBar.alpha = 0;
            CoverView.alpha = 0.;
        } completion:^(BOOL finished) {
            [CoverView removeFromSuperview];
        }];
        [UIUtils hideProgressHUD:self.view];
        
        Model_product *product = [Model_product productWithDictionary:JSON];
        self.headerView.product = product;
        self.describe.text = product.product_description;
//
        _moneyLabel.text = [NSString stringWithFormat:@"￥%@", product.product_price];
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
            labe.text = [NSString stringWithFormat:@"￥%d", [self.product.product_price intValue] * [count intValue]];
        };
    }
    return _countView;
}




- (void)addBuyButton{
    UIView *but = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    but.backgroundColor = RGB(60, 60, 60);
    [self.view addSubview:but];
    NSString *str = @"应付总额:";
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(ScreenWidth/2, but.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(16)} context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, textSize.width, but.height)];
    label.textColor = [UIColor whiteColor];
    label.font = YXCharacterFont(16);
    label.text = str;
    [but addSubview:label];
    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.width + label.origin.x + 5, 0, 110, but.height)];
    //_moneyLabel.backgroundColor = [UIColor orangeColor];
    _moneyLabel.textColor = RGB(199, 21, 133);
    [but addSubview:_moneyLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenWidth - 120, 0, 120, but.height);
    [button setTitle:@"购买课程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = RGB(199, 21, 133);
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
            
            YXPayInfoViewController *info = [[YXPayInfoViewController alloc] init];
            info.order = order;
            [self pushViewController:info];

        } failure:^(NSError *error, id JSON) {
            [UIUtils hideProgressHUD:self.view];
        }];
    }

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.6, ScreenWidth, 0.6)];
            line1.backgroundColor = RGB(220, 220, 220);
            [cell addSubview:line1];
        }
        return cell;
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"DateCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 60, 44)];
            _label.font = YXCharacterFont(17);
            _label.textAlignment = NSTextAlignmentRight;
            _label.textColor = RGB(199, 21, 133);
            [cell addSubview:_label];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.6)];
            line.backgroundColor = RGB(220, 220, 220);
            [cell addSubview:line];
            
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.6, ScreenWidth, 0.6)];
            line1.backgroundColor = RGB(220, 220, 220);
            [cell addSubview:line1];
            
            cell.textLabel.font = YXCharacterFont(17);
            cell.textLabel.textColor = RGB(60, 60, 60);
        }

        cell.textLabel.text = @"选择日期";
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           // [cell.contentView addSubview:self.scrollView];
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(0, 0, self.view.width, 38);
//            [button setTitle:@"选择日期" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:button];
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        YXCalendarViewController *calendar = [[YXCalendarViewController alloc] init];
        if (_indexPa != nil) {
            calendar.index = _indexPa;
        }
        calendar.dateChoose = ^(NSString *dateString, NSIndexPath *path){
            YXLog(@"chooseData = %@ --- %@ ", dateString , path);
            _label.text = dateString;
            _indexPa = path;
        };

        [self pushViewController:calendar];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1){
        return 44;
    }
    return 400;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        return self.buttonView;
//    }
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    if (section == 0) {
//        return 0.1;
//    }
//    return 44;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 10;
    }
    return 0.1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [self.headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}
@end
