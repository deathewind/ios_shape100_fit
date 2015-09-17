//
//  YXCalendarViewController.h
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BaseViewController.h"

@interface YXCalendarViewController : BaseViewController
@property(nonatomic, strong) NSIndexPath *index;

@property(nonatomic,copy) void(^dateChoose)(NSString *dateString, NSIndexPath *path);
@end
