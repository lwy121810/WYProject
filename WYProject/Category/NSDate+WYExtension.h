//
//  NSDate+WYExtension.h
//  WYProject
//
//  Created by lwy1218 on 16/9/26.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WYExtension)
/// 日期所在的年份 如返回2018 表示当前为2018年
@property (readonly, assign, nonatomic) NSInteger wy_year;
/// 日期所在的月份 如返回2 表示当前是二月份
@property (readonly, assign, nonatomic) NSInteger wy_month;
/// date日期所在的月份的第几天（如5:表示为所在月份的5号）
@property (readonly, assign, nonatomic) NSInteger wy_day;
/// date是所在星期的第几天 （如5，就是周六（从周日开始））
@property (readonly, assign, nonatomic) NSInteger wy_weekday;
/// 日期所在星期是日期所在年份的第几个星期 如返回5 表示日期所在星期是该年份的第五周
@property (readonly, assign, nonatomic) NSInteger wy_weekOfYear;
/// 日期所在月份共有多少天
@property (readonly, assign, nonatomic) NSInteger numberOfDaysInMonth;
/**
 是否是今天
 
 @return YES:该日期是今天 NO:该日期不是今天
 */
- (BOOL)wy_isToday;

- (BOOL)wy_isTomorrow;
- (BOOL)wy_isYesterday;
- (BOOL)wy_isWeekend;
- (BOOL)wy_isSameDayWithOtherDate:(NSDate *)otherDate;

/**
 *  返回几个月之后的时间
 */
- (NSDate *)wy_dateByAddingMonths:(NSInteger)months;
/**
 *  返回几个月之前的时间
 */
- (NSDate *)wy_dateBySubtractingMonths:(NSInteger)months;
/**
 *  返回几天之后的时间
 */
- (NSDate *)wy_dateByAddingDays:(NSInteger)days;
/**
 *  返回几天之前的时间
 */
- (NSDate *)wy_dateBySubtractingDays:(NSInteger)days;

/**
 *  转成时间格式的时间字符
 */
- (NSString *)wy_stringWithFormat:(NSString *)format;


/**
 是否跟另一日期在同一星期内
 
 @param otherDate 另一日期
 @return YES: 在同一个星期内 NO:不在同一周内
 */
- (BOOL)wy_sameWeekWithOtherDate:(NSDate *)otherDate;


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
- (NSInteger)wy_differenceDaysWithOtherDate:(NSDate *)otherDate;


/// 转为时间戳字符串
- (NSString *)wy_toTimestamp;


/**
 转成字符串

 @param format 格式
 @return 字符串
 */
- (NSString *)wy_stringWithFormat:(NSString *)format;

- (NSArray <NSDate *>*)betweenDaysWithOtherDate:(NSDate *)otherDate;

/**
 *  时间转成一定格式的时间
 *
 *  @param string 要转成时间的字符
 *  @param format 要转成的时间格式
 *
 *  @return 返回时间
 */
+ (instancetype)wy_dateFromString:(NSString *)string format:(NSString *)format;
/**
 *  传入一个年月日的时间数返回一个时间
 */
+ (instancetype)wy_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
