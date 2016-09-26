//
//  NSDate+WYExtension.h
//  WYProject
//
//  Created by lwy1218 on 16/9/26.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WYExtension)

@property (readonly, nonatomic) NSInteger wy_year;
@property (readonly, nonatomic) NSInteger wy_month;
@property (readonly, nonatomic) NSInteger wy_day;
@property (readonly, nonatomic) NSInteger wy_weekday;

@property (readonly, nonatomic) NSInteger numberOfDaysInMonth;
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
