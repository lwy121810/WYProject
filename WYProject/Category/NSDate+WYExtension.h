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
