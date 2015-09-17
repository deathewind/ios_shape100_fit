//
//  CalendarFrame.h
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXDateManager.h"
//#define CellHeight 46
//#define HeaderViewHeight 30
@interface CalendarFrame : NSObject
@property (nonatomic,strong)  NSDateComponents *dateComponents;
@property (nonatomic, readonly) NSInteger firstDay;
@property (nonatomic, readonly) NSInteger daysOfmonth;
@property (nonatomic, readonly) NSInteger weeksOfmonth;
@property (nonatomic, assign) BOOL isCurrentMonth;
@end
