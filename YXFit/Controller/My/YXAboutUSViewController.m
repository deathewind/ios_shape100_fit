//
//  YXAboutUSViewController.m
//  YXFit
//
//  Created by 何军 on 25/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXAboutUSViewController.h"
@interface YXAboutUSViewController()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation YXAboutUSViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleBar.text = @"关于我们";
    [self UI_US];
    [self addBackBtn];
    // Do any additional setup after loading the view.
}
- (void)UI_US{
    UITableView *tabelView_teacher = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
    tabelView_teacher.backgroundColor = [UIColor whiteColor];
    tabelView_teacher.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView_teacher.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tabelView_teacher.delegate = self;
    tabelView_teacher.dataSource  = self;
    [self.view addSubview:tabelView_teacher];
}
- (void)addBackBtn{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:button_back];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: 	UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
      //  cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView_logo = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40, ScreenWidth -  25 * 2, 115)];
        imageView_logo.image = [UIImage imageFileName:@"DF.png"];
        [cell addSubview:imageView_logo];
        
        UIView *view_line_one = [[UIView alloc] initWithFrame:CGRectMake(6, imageView_logo.origin.y + imageView_logo.height + 50, ScreenWidth - 6 * 2, 1)];
        view_line_one.backgroundColor = RGB(229, 229, 229);
        [cell addSubview:view_line_one];
        
        UIView *view_line_two = [[UIView alloc] initWithFrame:CGRectMake(6, view_line_one.origin.y + 55, ScreenWidth - 6 * 2, 1)];
        view_line_two.backgroundColor = RGB(229, 229, 229);
        [cell addSubview:view_line_two];
        
        UILabel *verLab = [[UILabel alloc] initWithFrame:CGRectMake(20, view_line_one.origin.y, ScreenWidth/2 - 20, 55)];
        verLab.text = @"当前版本:";
        verLab.textColor = RGB(136, 136, 136);
        verLab.textAlignment = NSTextAlignmentLeft;
        verLab.font = YXCharacterFont(16);
        [cell addSubview:verLab];
        
        UILabel *verNum = [[UILabel alloc] initWithFrame:CGRectMake(verLab.width + verLab.origin.x, verLab.origin.y, verLab.width, verLab.height)];
        verNum.text = [NSString stringWithFormat:@"%@",[UIUtils Version]];
        verNum.textColor = RGB(136, 136, 136);
        verNum.textAlignment = NSTextAlignmentRight;
        verNum.font = YXCharacterFont(16);
        [cell addSubview:verNum];
        
//        UILabel *label_phone = [[UILabel alloc] initWithFrame:CGRectMake(20, view_line_one.frame.origin.y + 13, ScreenWidth - 20, 30)];
//        label_phone.backgroundColor = [UIColor clearColor];
////#ifdef _ALPHA
////        label_phone.text = [NSString stringWithFormat:@"当前版本:                                  %@.%@",[UIUtils Version],[UIUtils buildVersion]];
////#else
////        label_phone.text = [NSString stringWithFormat:@"当前版本:                                        %@",[UIUtils Version]];
////#endif
//        label_phone.text = [NSString stringWithFormat:@"当前版本:                                        %@",[UIUtils Version]];
//        label_phone.textColor = RGB(136, 136, 136);
//        label_phone.textAlignment = NSTextAlignmentLeft;
//        label_phone.font = YXCharacterFont(16);
//        [cell addSubview:label_phone];
        
        UILabel *label_copy = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight - 70 - self.navBar.height, ScreenWidth, 60)];
        label_copy.backgroundColor = [UIColor clearColor];
        label_copy.text = @"shape100.com\n有型100 版权所有\nCopyright©2014 Shape100.All Right Reserved";
        label_copy.textColor = RGB(136, 136, 136);
        label_copy.numberOfLines = 3;
        label_copy.textAlignment = NSTextAlignmentCenter;
        label_copy.font = YXCharacterFont(13);
        [cell addSubview:label_copy];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.height;
}

@end
