//
//  ExpandTableViewHeader.h
//  YXFit
//
//  Created by 何军 on 7/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#define headerViewHeight 210
@interface ExpandTableViewHeader : UIView
@property (nonatomic) UIImage *headerImage;
@property (nonatomic) NSString *imageUrl;
//+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
//+ (id)parallaxHeaderViewWithCGSize:(CGSize)headerSize;

@property(nonatomic, strong) Model_product *product;

@property(nonatomic, strong) Model_club  *club;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
@end
