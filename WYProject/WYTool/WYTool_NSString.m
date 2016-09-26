//
//  WYTool_NSString.m
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/17.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYTool_NSString.h"

@implementation WYTool_NSString
#pragma mark - 判断输入框输入的内容是否为空 yes 表示为空 no 表示有内容
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
/**检查字符是否为空 如果为空 返回无 如果不为空 返回自身**/
+ (NSString *)checkStringWithString:(NSString *)fromString
{
    NSString *str;
    if ([WYTool_NSString isBlankString:fromString]) {
        str = @"无";
    }else{
        str = fromString;
    }
    return str;
}
/**比较两个日期的大小 YES **/
+ (BOOL)compareOneDate:(NSDate *)oneDate withOtherDate:(NSDate *)otherDate
{
//    {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};

    NSComparisonResult result = [oneDate compare:otherDate];
    if (result == NSOrderedAscending) {
        return YES;
    }
    return NO;
}
/**时间转化为字符串**/
+ (NSString *)turnToStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/**字符串转时间**/
+ (NSDate *)turnToDateWithString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}
/**
 *  改变字符串中某些字符的字体颜色
 *
 *  @param allString    全部的字符串
 *  @param textColor    全部字符串的字体颜色
 *  @param changeString 要改变字体颜色的字符串 必须是全部字符串中的字符
 *  @param changeColor  要改变的字体颜色
 *
 *  @return 返回改变后的结果
 */
+ (NSMutableAttributedString *)changeColorAllString:(NSString *)allString
                                          textColor:(UIColor *)textColor
                                   needChangeString:(NSString *)changeString
                                        changeColor:(UIColor *)changeColor
{
    NSRange changeRange = [allString rangeOfString:changeString];
    NSMutableAttributedString *allStr = [[NSMutableAttributedString alloc] initWithString:allString attributes:@{NSForegroundColorAttributeName:textColor}];
    [allStr addAttributes:@{NSForegroundColorAttributeName:changeColor} range:changeRange];
    
    return allStr;
}

/**删除掉字典中value为空的数据 */
+ (NSMutableDictionary *)removeNullValueWithDictionary:(NSMutableDictionary *)dict
{
    if (!dict) return nil;
    for (NSString *key in [dict allKeys]) {
        BOOL isNull = [[dict valueForKey:key] isEqual:[NSNull null]];
        if (isNull) {
            [dict removeObjectForKey:key];
        }
    }
    return dict;
}
@end
