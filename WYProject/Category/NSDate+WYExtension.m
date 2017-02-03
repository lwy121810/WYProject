//
//  NSDate+WYExtension.m
//  WYProject
//
//  Created by lwy1218 on 16/9/26.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "NSDate+WYExtension.h"

#define LogicReturn_Date @"ReturnDate"
#define LogicReturn_DateComp @"ReturnDateComponents"

#define WY_TIME_ADD_ZEROMATCH(baseTime) ([baseTime length] > 1 ? baseTime : [NSString stringWithFormat:@"0%@", baseTime])


typedef enum {
    DateFormatType_YMD = 0,//年月日
    DateFormatType_YMDHMS//年月日，时分秒
}DateFormatType;
@implementation NSDate (WYExtension)
- (NSInteger)wy_year
{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSYearCalendarUnit fromDate:self];
    return component.year;
#else
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.year;
    
#endif
    
}

- (NSInteger)wy_month
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSMonthCalendarUnit fromDate:self];
    return component.month;
#else
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.month;
#endif
}

- (NSInteger)wy_day
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSDayCalendarUnit fromDate:self];
    return component.day;
#else
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.day;
#endif
    
}

- (NSInteger)wy_weekday
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return component.weekday;
#else
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp.weekday;
#endif
    
}

- (NSInteger)numberOfDaysInMonth
{

    NSCalendar *c = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self];
    return days.length;
#else
    
    NSRange dayss = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return dayss.length;
#endif

}

#define WYString_Format(...) [NSString stringWithFormat:__VA_ARGS__]
/**
 * 根据某年某月获得当月有多少天
 */
- (int)getTotalDaysNumberOfYear:(int)year andMonth:(int)month
{
    //传入的时间转成字符
    NSString *dateString = WYString_Format(@"%d-%d-%d", year, month, 1);
    //根据字符转成包含时间信息的字典
    NSDictionary* dateInfoDic = [self dateAndDateComponentsDictInfoWithDateFormatType:DateFormatType_YMD andTimeMatchStr:dateString];
    //获得时间
    NSDate* date = [dateInfoDic objectForKey:LogicReturn_Date];
    NSCalendar* c = [NSCalendar currentCalendar];
    //获得总天数
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (int)days.length;
}
/**
 *  根据传入的字符串获得NSDate和NSDateComponents  字符串格式为yyyy-MM-dd格式 或者yyyy-MM-dd HH... @{ LogicReturn_Date : nowDate,
 LogicReturn_DateComp : dateComp }
 */
- (NSDictionary*)dateAndDateComponentsDictInfoWithDateFormatType:(DateFormatType)dateFormate andTimeMatchStr:(NSString*)timeMatchStr
{
    timeMatchStr = [self timeMatchedString4Base:timeMatchStr];
    if (dateFormate == DateFormatType_YMD) {
        timeMatchStr = [[timeMatchStr componentsSeparatedByString:@" "] firstObject];
    }
    
    NSDictionary * dateFormateDic = @{ WYString_Format(@"%d", (int)DateFormatType_YMD) : @"yyyy-MM-dd",
                         WYString_Format(@"%d", (int)DateFormatType_YMDHMS) : @"yyyy-MM-dd HH:mm:ss" };
    
    //获得时间格式
    NSString* dateFormateStr = [dateFormateDic objectForKey:[NSString stringWithFormat:@"%d", (int)dateFormate]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormateStr];
    
    //translate to NSDate(solve the 8 hours!)
    NSDate* nowDate = [formatter dateFromString:timeMatchStr];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:nowDate];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    //Date转换DateComps
    NSDateComponents* dateComp = [self dateComponentChangedByDate:nowDate dateFormatType:dateFormate];
    //    NSLog(@"date==%@\ndateComp==%@", nowDate, dateComp);
    return @{LogicReturn_Date : nowDate,
             LogicReturn_DateComp : dateComp };
    
}

/**
 *  NSDate转NSDateComponents
 */
- (NSDateComponents *)dateComponentChangedByDate:(NSDate *)baseDate dateFormatType:(DateFormatType)formatType
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    if ((int)formatType == DateFormatType_YMDHMS) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    }
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:baseDate];
    return dateComp;
}

/**
 *  根据传入的时间字符转化为 YY-MM-DD hh:mm:ss标准格式（个位数的补成双位数）
 */
- (NSString*)timeMatchedString4Base:(NSString*)baseTimeStr
{
    NSArray* allTimesCompoents = [baseTimeStr componentsSeparatedByString:@" "];
    if (allTimesCompoents.count == 1) {
        NSString* ymdStr = [allTimesCompoents firstObject];
        NSArray* ymdCompoents = [ymdStr componentsSeparatedByString:@"-"];
        if (ymdCompoents.count == 3) {
            //TSC_TIME_ADD_ZEROMATCH 自动补齐字符长度
            return WYString_Format(@"%@-%@-%@ 00:00:00",
                                    [ymdCompoents objectAtIndex:0],
                                    WY_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:1]),
                                    WY_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:2]));
        }
    }
    else if (allTimesCompoents.count == 2) {
        NSArray* ymdCompoents = [[allTimesCompoents firstObject] componentsSeparatedByString:@"-"];
        NSArray* hmsCompoents = [[allTimesCompoents objectAtIndex:1] componentsSeparatedByString:@":"];
        if (ymdCompoents.count == 3 && hmsCompoents.count == 3) {
            return WYString_Format(@"%@-%@-%@ %@:%@:%@",
                                    [ymdCompoents objectAtIndex:0],
                                    WY_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:1]),
                                    WY_TIME_ADD_ZEROMATCH([ymdCompoents objectAtIndex:2]),
                                    WY_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:0]),
                                    WY_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:1]),
                                    WY_TIME_ADD_ZEROMATCH([hmsCompoents objectAtIndex:2]));
        }
    }
    return baseTimeStr;
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
