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
/**
 日期所在的年份
 
 @return 年份 如返回2018 表示当前为2018年
 */
- (NSInteger)wy_year
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSYearCalendarUnit fromDate:self];
    return component.year;
#else
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.year;
#endif
}
- (NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    NSDateComponents *dateComp = [calendar components:unitFlags fromDate:self];
    return dateComp;
}
/**
 日期所在的月份
 
 @return 月份 如返回2 表示当前是二月份
 */
- (NSInteger)wy_month
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSMonthCalendarUnit fromDate:self];
    return component.month;
#else
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.month;
#endif
}

/**
 date日期所在的月份的第几天（如5:表示为所在月份的5号）
 
 @return return value description
 */
- (NSInteger)wy_day
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSDayCalendarUnit fromDate:self];
    return component.day;
#else
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.day;
#endif
}


/**
 date是所在星期的第几天 （如5，就是周六（从周日开始））
 
 @return return value description
 */
- (NSInteger)wy_weekday
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_8_0
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return component.weekday;
#else
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.weekday;
#endif
}

/**
 日期所在星期是日期所在年份的第几个星期
 
 @return 如返回5 表示日期所在星期是该年份的第五周
 */
- (NSInteger)wy_weekOfYear
{
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.weekOfYear;
}

/**
 日期所在星期是该日期所在月份的第几周

 @return 如返回2 表示该日期是该月份的第二周
 */
- (NSInteger)wy_weekOfMonth
{
    NSDateComponents* dateComp = [self getDateComponents];
    return dateComp.weekOfMonth;
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
    
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return days.length;
#endif
}

/**
 是否跟另一日期在同一星期内

 @param otherDate 另一日期
 @return YES: 在同一个星期内 NO:不在同一周内
 */
- (BOOL)wy_sameWeekWithOtherDate:(NSDate *)otherDate
{
    NSInteger year = [self wy_year];
    NSInteger otherYear = [otherDate wy_year];
    if (year != otherYear) {
        return NO;
    }
    NSInteger weekOfYear = [self wy_weekOfYear];
    NSInteger otherWeekOfYear = [otherDate wy_weekOfYear];
    
    return weekOfYear == otherWeekOfYear;
}

/**
 是否是今天

 @return YES:该日期是今天 NO:该日期不是今天
 */
- (BOOL)wy_isToday
{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
//    NSDate *today = [cal dateFromComponents:components];
//
//    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
//    NSDate *otherDate = [cal dateFromComponents:components];
//
//
//    if([today isEqualToDate:otherDate])
//    {
//        return YES;
//    }
    return [[NSCalendar currentCalendar] isDateInToday:self];
}

- (BOOL)wy_isTomorrow
{
    return [[NSCalendar currentCalendar] isDateInTomorrow:self];
}
- (BOOL)wy_isYesterday
{
    return [[NSCalendar currentCalendar] isDateInYesterday:self];
}
- (BOOL)wy_isWeekend
{
    return [[NSCalendar currentCalendar] isDateInWeekend:self];
}

- (BOOL)wy_isSameDayWithOtherDate:(NSDate *)otherDate
{
    return [[NSCalendar currentCalendar] isDate:self inSameDayAsDate:otherDate];
}


#define WYString_Format(...) [NSString stringWithFormat:__VA_ARGS__]
/**
 * 根据某年某月获得当月有多少天
 */

+ (NSUInteger)wy_numberOfDaysInYear:(NSUInteger)year andMonth:(NSUInteger)month
{
    NSDate* nowDate = [NSDate wy_dateWithYear:year month:month day:1];;
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:nowDate];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSCalendar* c = [NSCalendar currentCalendar];
    //获得总天数
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    return days.length;

}

/**
 *  根据传入的字符串获得NSDate和NSDateComponents  字符串格式为yyyy-MM-dd格式 或者yyyy-MM-dd HH... @{ LogicReturn_Date : nowDate,
 LogicReturn_DateComp : dateComp }
 */
+ (NSDictionary*)dateAndDateComponentsDictInfoWithDateFormatType:(DateFormatType)dateFormate andTimeMatchStr:(NSString*)timeMatchStr
{
    timeMatchStr = [self wy_timeMatchedString4Base:timeMatchStr];
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
    NSDateComponents* dateComp = [self wy_componentsFromDate:nowDate dateFormatType:dateFormate];
    //    NSLog(@"date==%@\ndateComp==%@", nowDate, dateComp);
    return @{LogicReturn_Date : nowDate,
             LogicReturn_DateComp : dateComp };
    
}

/**
 *  NSDate转NSDateComponents
 */
+ (NSDateComponents *)wy_componentsFromDate:(NSDate *)fromDate dateFormatType:(DateFormatType)formatType
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    if ((int)formatType == DateFormatType_YMDHMS) {
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitTimeZone;
    }
    NSDateComponents* dateComp = [calendar components:unitFlags fromDate:fromDate];
    return dateComp;
}

/**
 *  根据传入的时间字符转化为 YY-MM-DD hh:mm:ss标准格式（个位数的补成双位数）
 */
+ (NSString*)wy_timeMatchedString4Base:(NSString*)baseTimeStr
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
/**
 转成字符串
 
 @param format 格式
 @return 字符串
 */
- (NSString *)wy_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}
/**
 *  返回几个月之后的时间
 */
- (NSDate *)wy_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}
/**
 *  返回几个月之前的时间
 */
- (NSDate *)wy_dateBySubtractingMonths:(NSInteger)months
{
    return [self wy_dateByAddingMonths:-months];
}
/**
 *  返回几天之后的时间
 */
- (NSDate *)wy_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  返回几天之前的时间
 */
- (NSDate *)wy_dateBySubtractingDays:(NSInteger)days
{
    return [self wy_dateByAddingDays:-days];
}

/**
 与其他日期的间隔天数
 
 aDate      :   2018.5.7
 otherDate  :   2018.5.9
 NSInteger result = [aDate wy_differenceDaysWithOtherDate:otherDate];
 > result == 1  表明otherDate与aDate间隔了一天 （而不是 (9-7) = 2天， 因为中间只隔了2018.5.8这一天）
 相反的 [otherDate wy_differenceDaysWithOtherDate:aDate]
 > result == -1 表明 aDate 与 otherDate间隔了-1 天 因为aDate比otherDate小 所以返回了负数
 
 @param otherDate 其他日期
 @return 间隔天数
 */
- (NSInteger)wy_differenceDaysWithOtherDate:(NSDate *)otherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    NSCalendarOptions options = NSCalendarWrapComponents;
    
    NSDateComponents *components = [calendar components:unit fromDate:self toDate:otherDate options:options];
    
    
    // 该方法也可以
//    NSCalendarUnit unit = NSCalendarUnitDay;
//    NSTimeInterval interval = 0;
//    BOOL result = [[NSCalendar currentCalendar] rangeOfUnit:unit startDate:&now interval:&interval forDate:date];
//    NSInteger day = interval / (24 * 60 * 60);
    
    return components.day;
}

- (NSArray <NSDate *>*)betweenDaysWithOtherDate:(NSDate *)otherDate
{
    NSMutableArray *dates = @[].mutableCopy;
    
    NSDate *earlierDate = [self earlierDate:otherDate];
    NSDate *laterDate = [self laterDate:otherDate];
    
    NSInteger days = [earlierDate wy_differenceDaysWithOtherDate:laterDate];
    
    while (days > 0) {
        NSDate *date = [earlierDate wy_dateByAddingDays:1];
        [dates addObject:date];
        days--;
    }
//    for (NSInteger i = 0; i < days; i++) {
//        NSDate *date = [earlierDate wy_dateByAddingDays:1];
//        [dates addObject:date];
//    }
    return dates.copy;
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

/// 转为时间戳字符串
- (NSString *)wy_toTimestamp
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[self timeIntervalSince1970]];
    return timeSp;
}
@end
