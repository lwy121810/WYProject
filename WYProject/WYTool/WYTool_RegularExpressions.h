//
//  WYTool_RegularExpressions.h
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/6/20.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
/**封装的正则表达工具类**/
@interface WYTool_RegularExpressions : NSObject

/*!
 *  是否为电话号码【简单写法】
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 YES:是 NO：不是
 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNum;

/*!
 *  是否为电话号码【复杂写法】
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/*!
 *  判断是否是：移动手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 移动手机号
 */
+ (BOOL)isChinaMobile:(NSString *)phoneNum;

/*!
 *  判断是否是：联通手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 联通手机号
 */
+ (BOOL)isChinaUnicom:(NSString *)phoneNum;

/*!
 *  判断是否是：电信手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 电信手机号
 */
+ (BOOL)isChinaTelecom:(NSString *)phoneNum;

/*!
 *  判断具体是哪个运营商的手机号
 *
 *  @param phoneNum 传入需要检测的字符串
 *
 *  @return 返回：中国移动、中国联通、中国电信、未知
 */
+ (NSString *)getPhoneNumType:(NSString *)phoneNum;

/*!
 *  检测是否为邮箱
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isEmailQualified:(NSString *)emailStr;

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isPasswordQualified:(NSString *)passwordStr;

/*!
 *  验证身份证号（15位或18位数字）
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isIdCardNumberQualified:(NSString *)idCardNumberStr;

/*!
 *  验证IP地址（15位或18位数字）
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isIPAddress:(NSString *)iPAddressStr;

/*!
 *  验证输入的是否全为数字
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isAllNumber:(NSString *)allNumberStr;

/*!
 *  验证由26个英文字母组成的字符串
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isEnglishAlphabet:(NSString *)englishAlphabetStr;

/*!
 *  验证输入的是否是URL地址
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isUrl:(NSString *)urlStr;

/*!
 *  验证输入的是否是中文
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isChinese:(NSString *)chineseStr;

/*!
 *  验证输入的是否是高亮显示
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isNormalText:(NSString *)normalStr WithHighLightText:(NSString *)HighLightStr;

/*!
 *  是否为常用用户名（根据自己需求改）
 *
 *  @param userNameStr userNameStr
 *
 *  @return 返回检测结果 是或者不是（6-20位数字+字母组合）
 */
+ (BOOL)isUserNameInGeneral:(NSString *)userNameStr;

/*!
 *  车牌号验证
 *
 *  @param carNumber carNumber
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isValidateCarNumber:(NSString *)carNumber;

/*!
 *  车型验证
 *
 *  @param CarType CarType
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isValidateCarType:(NSString *)CarType;

/*!
 *  昵称验证
 *
 *  @param nickname nickname
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)isValidateNickname:(NSString *)nickname;
@end
