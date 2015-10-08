//
//  DetailCell.h
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height;
- (void)setLeftString:(NSString *)left andOrderStatus:(NSString *)status;
- (void)setLeftString:(NSString *)left rightString:(NSString *)right;
@end
