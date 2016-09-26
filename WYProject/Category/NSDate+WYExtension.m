//
//  NSDate+WYExtension.m
//  WYProject
//
//  Created by lwy1218 on 16/9/26.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "NSDate+WYExtension.h"

@implementation NSDate (WYExtension)
- (NSInteger)wy_year
{
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDateComponents *component = [calendar components:NSYearCalendarUnit fromDate:self];
    //    return component.year;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.year;
}

- (NSInteger)wy_month
{
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDateComponents *component = [calendar components:NSMonthCalendarUnit fromDate:self];
    //    return component.month;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.month;
    
}

- (NSInteger)wy_day
{
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDateComponents *component = [calendar components:NSDayCalendarUnit fromDate:self];
    //    return component.day;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.day;
    
}

- (NSInteger)wy_weekday
{
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSDateComponents *component = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    //    return component.weekday;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.weekday;
}

- (NSInteger)numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange dayss = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    //    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
    //                           inUnit:NSMonthCalendarUnit
    //                          forDate:self];
    return dayss.length;
}

- (NSString *)wy_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSDate *)wy_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)wy_dateBySubtractingMonths:(NSInteger)months
{
    return [self wy_dateByAddingMonths:-months];
}
- (NSDate *)wy_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
/**
 *  返回几天之后的时间
 */
- (NSDate *)wy_dateBySubtractingDays:(NSInteger)days
{
    return [self wy_dateByAddingDays:-days];
}

+ (instancetype)wy_dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)wy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    return [calendar dateFromComponents:components];
}
@end
