//
//  LMDateManager.m
//  CalendarDemo
//
//  Created by zero on 15/6/16.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "YXDateManager.h"

@implementation YXDateManager


+ (BOOL)earlierThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(_year < year){
        return YES;
    }else if(_year == year){
        if(_month < month){
            return YES;
        }else if(_month == month && _day < day){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)isEqualToDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(year == _year && month == _month && day == _day){
        return YES;
    }
    return NO;
}
+ (BOOL)laterThanDate:(NSDate*)_date WithYear:(NSInteger)_year Month:(NSInteger)_month Day:(NSInteger)_day{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if(_year > year){
        return YES;
    }else if(_year == year){
        if(_month > year){
            return YES;
        }else if(_month == month && _day > day){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)laterThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components =  [self getDateComponentsWithDate:_date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if(_hour > hour){
        return YES;
    }else if(_hour == hour && _minute > minute){
        return YES;
    }
    return NO;
}
+ (BOOL)isEqualToDate:(NSDate *)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components = [self getDateComponentsWithDate:_date];
    if(components.hour == _hour && components.minute == _minute){
        return YES;
    }
    return NO;
}
+ (BOOL)earlierThanDate:(NSDate*)_date WithHour:(NSInteger)_hour Minute:(NSInteger)_minute{
    NSDateComponents* components = [self getDateComponentsWithDate:_date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    if(_hour < hour){
        return YES;
    }else if(_hour == hour && _minute < minute){
        return YES;
    }
    return NO;
}

+ (NSDate*)getDateWithHour:(NSInteger)_hour Minutes:(NSInteger)_minutes{
    //    _hour += 8;
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *myComponents = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
    myComponents.calendar = gregorian;
    myComponents.hour = _hour;
    myComponents.minute = _minutes;
    NSDate* date = [gregorian dateFromComponents:myComponents];
    return date;
}
+ (NSString*)toStringWithDate:(NSDate*)date Formatter:(NSString*)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSString* string = [dateFormatter stringFromDate:date];
    return string;
}

+ (NSDate*)toDateWithString:(NSString*)time Formatter:(NSString*)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    //    [dateFormatter setTimeZone:timeZone];
    NSDate* date = [dateFormatter dateFromString:time];
    return date;
}




+ (NSInteger)getDaysInMonth:(NSInteger)month year:(NSInteger)year
{
    NSInteger daysInFeb = 28;
    if (year%4 == 0) {
        daysInFeb = 29;
    }
    NSInteger daysInMonth [12] = {31,daysInFeb,31,30,31,30,31,31,30,31,30,31};
    return daysInMonth[month-1];
}
+ (NSArray*)getMonths{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return calendar.monthSymbols;
}
+ (NSDateComponents*)getOtherMonthComponentsWithCurrentDate:(NSInteger)month{
    if (month == 0) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond |
        NSCalendarUnitCalendar;
        comps = [calendar components:unitFlags fromDate:[NSDate date]];
        return comps;
        
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* new = [[NSDateComponents alloc]init];
    new.month = month;
    NSDate *date =  [calendar dateByAddingComponents:new toDate:[NSDate date] options:NSCalendarMatchNextTime];
    //  NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitCalendar;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}
+ (NSDateComponents*)getDateComponentsWithDate:(NSDate*)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitWeekOfMonth | NSCalendarUnitEra) fromDate:[NSDate date]];
    return components;
}
+ (NSDateComponents *)firstDateComponentsWithMonthComponents:(NSDateComponents *)monthComponents
{
    NSDateComponents *month = [monthComponents copy];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitCalendar;
    month.day = 1;
    comps = [calendar components:unitFlags fromDate:[calendar dateFromComponents:month]];
    return comps;
}

@end

