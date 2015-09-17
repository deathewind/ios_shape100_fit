//
//  LMDateManager.h
//  CalendarDemo
//
//  Created by zero on 15/6/16.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CellHeight 46
#define HeaderViewHeight 30
//#define CellWidth 45
#define CellLine 0.6
@interface YXDateManager : NSObject


// return the count of day in a certain month ,a certain year
+ (int)getDaysInMonth:(int)month year:(int)year;

//获取某个月的第一天
+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents;

// get the dateComponents from the date, you can get some info from dateComponents
+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date;

// return the array of month name in a year
+ (NSArray*)getMonths;

// according to the current date , +/- month , return a new dateComponents with new month
+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month;

//Time
+ (BOOL)isEqualToDate:(NSDate *)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;
+ (BOOL)earlierThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;
+ (BOOL)laterThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute;

//Year
+ (BOOL)isEqualToDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;
+ (BOOL)earlierThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;
+ (BOOL)laterThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day;

+ (NSDate*)getDateWithHour:(NSInteger)_hour Minutes:(NSInteger)_minute;
//yyyy-MM-dd hh:mm:ss
+ (NSString*)toStringWithDate:(NSDate*)date Formatter:(NSString*)formatter;
+ (NSDate*)toDateWithString:(NSString*)time Formatter:(NSString*)formatter;






////根据date获取dateComponents
//+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date;
////获取当前的下几天
//+ (NSDateComponents *)dateComponentsWithComponents:(NSDateComponents *)dateComponents
//                                          afterDay:(NSInteger)day;


@end
