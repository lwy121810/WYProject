//
//  WYTool_NSString.h
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/17.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYTool_NSString : NSObject

/**判断输入框输入的内容是否为空 yes 表示为空 no 表示有内容**/
+ (BOOL) isBlankString:(NSString *)string;


/**检查字符是否为空 如果为空 返回无 如果不为空 返回自身**/
+ (NSString *)checkStringWithString:(NSString *)fromString;

/**时间转化为yyyy-MM-dd格式字符串**/
+ (NSString *)turnToStringWithDate:(NSDate *)date;
/**字符串转时间**/
+ (NSDate *)turnToDateWithString:(NSString *)dateString;

/**比较两个日期的大小 YES **/
+ (BOOL)compareOneDate:(NSDate *)oneDate withOtherDate:(NSDate *)otherDate;
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
                                        changeColor:(UIColor *)changeColor;
/**删除掉字典中value为空的数据 */
+ (NSMutableDictionary *)removeNullValueWithDictionary:(NSMutableDictionary *)dict;
@end
