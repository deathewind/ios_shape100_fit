//
//  YXCollectionViewCell.h
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel* dateLabel;
// change the background of the current day to  red
@property (nonatomic,assign) BOOL weekend;
@end


@interface YXCollectionHeaderView : UICollectionReusableView
@property (nonatomic,strong) UILabel *titleLabel;
@end




@protocol footerViewDelegate <NSObject>
- (void)loadMoreTime:(UIButton *)button;
@end
@interface YXCollectionFooterView : UICollectionReusableView
@property (nonatomic,strong) UIButton *button;
@property (nonatomic, assign) id<footerViewDelegate>delegate;
@end