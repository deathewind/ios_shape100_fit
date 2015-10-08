//
//  PayInfoCell.h
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayInfoCell : UITableViewCell
@property(nonatomic, assign) BOOL isSelected;
- (void)setIcon:(NSString *)icon callName:(NSString *)name;
@end
