//
//  CalendarFrame.m
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CalendarFrame.h"

@implementation CalendarFrame
- (void)setDateComponents:(NSDateComponents *)dateComponents{
    _dateComponents = dateComponents;
    NSDateComponents *firstDateMonthComponents = [YXDateManager firstDateComponentsWithMonthComponents:dateComponents];
    
    NSInteger firstDay = firstDateMonthComponents.weekday - 1;

    NSInteger daysOfmonth = [YXDateManager getDaysInMonth:dateComponents.month year:dateComponents.year];
    NSInteger weeksOfmonth = (daysOfmonth + firstDay)/7;
    if((daysOfmonth + firstDay)%7 != 0){
        weeksOfmonth ++ ;
    }
    _firstDay = firstDay;
    _daysOfmonth = daysOfmonth;
    _weeksOfmonth = weeksOfmonth;
    if(dateComponents.month == [YXDateManager getDateComponentsWithDate:[NSDate date]].month){
        _isCurrentMonth = YES;
    }else{
        _isCurrentMonth  = NO;
    }

}
@end
