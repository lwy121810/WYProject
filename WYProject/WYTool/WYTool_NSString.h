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
@end
