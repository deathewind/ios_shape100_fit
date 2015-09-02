//
//  YXFeedbackViewController.m
//  YXFit
//
//  Created by 何军 on 25/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXFeedbackViewController.h"
@interface YXFeedbackViewController()
@property(nonatomic, strong) UITextView *textView;
@end
@implementation YXFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTextView];
    [self creatBackButton];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_touchOutSide:)];
    [self.view addGestureRecognizer:tapGesture];
}
- (void)p_touchOutSide:(UITapGestureRecognizer*)tapGesture {
    [self.textView resignFirstResponder];
}
- (void)addTextView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, 40)];
    label.text = @"欢迎您提供宝贵的意见和建议";
    label.font = YXCharacterFont(16);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, label.origin.y + label.height, ScreenWidth - 10 * 2, 150)];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    [self.view addSubview:self.textView];
    
    UIButton *put = [UIButton buttonWithType:UIButtonTypeCustom];
    put.frame = CGRectMake(10, self.textView.height + self.textView.origin.y + 15, ScreenWidth - 20, 44);
    [put setTitle:@"提交反馈" forState:UIControlStateNormal];
    put.layer.cornerRadius = 5;
    put.backgroundColor = self.navBar.backgroundColor;
    put.titleLabel.font = YXCharacterFont(16);
    [put addTarget:self action:@selector(putSuess) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:put];
    
}
- (void)putSuess{
    
}
@end
