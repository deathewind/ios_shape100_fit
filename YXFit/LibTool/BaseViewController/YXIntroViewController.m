//
//  YXIntroViewController.m
//  YXFit
//
//  Created by 何军 on 26/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXIntroViewController.h"
@interface YXIntroViewController()<UIScrollViewDelegate>
@property(nonatomic, strong) UIPageControl *pageControl;
@end
@implementation YXIntroViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(40, 40, 40);
    [self initGuideView];
}
- (void)initGuideView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.width * 3, scrollView.height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [self addImageView:scrollView at:0 name:@"begin_one.png"];
    [self addImageView:scrollView at:1 name:@"begin_two.png"];
    [self addImageView:scrollView at:2 name:@"begin_three.png"];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 3;
    //self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:self.pageControl];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(self.view.width / 2 - 180 / 2, self.pageControl.frame.origin.y - 45, 180, 40);
//    [button setTitle:@"开启有型之旅!" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button.titleLabel setFont:YXCharacterFont(16)];
//    button.backgroundColor = [UIColor clearColor];
//    button.layer.borderColor = [UIColor orangeColor].CGColor;
//    [button addTarget:self action:@selector(onFinishedIntroButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    button.layer.borderWidth =.5;
//    button.layer.cornerRadius = 15;
//    [self.view addSubview:button];

}
- (void)addImageView:(UIScrollView *)scrollView at:(NSInteger)page name:(NSString *)name{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width * page, 0, self.view.width, self.view.height)];
    imageView.image = [UIImage imageFileName:name];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    if (page == 2) {
        imageView.userInteractionEnabled = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.width / 2 - 180 / 2, self.view.height - 75, 180, 40);
        [button setTitle:@"开启有型之旅" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:YXCharacterFont(16)];
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderColor = [UIColor orangeColor].CGColor;
        [button addTarget:self action:@selector(onFinishedIntroButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth =1;
        button.layer.cornerRadius = 15;
        [imageView addSubview:button];
    }
    [scrollView addSubview:imageView];
}
- (void)onFinishedIntroButtonPressed{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformMakeScale(2.0,2.0);
        self.view.alpha = 0.2;
    } completion:^(BOOL finished) {
        self.view.alpha = 0;
        [self.view removeFromSuperview];
        [APPDELEGATE loadMainView];
    }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
}
@end
