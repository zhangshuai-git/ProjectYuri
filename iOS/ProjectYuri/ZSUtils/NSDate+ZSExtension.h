//
//  NSDate+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZSExtension)

///< 获取当前时间的: 前一周(day:-7)丶前一个月(month:-30)丶前一年(year:-1)的时间戳(距1970的秒数)
+ (NSTimeInterval)getExpectTimestamp:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;

///格式化距1970的秒数
+ (NSString *)formatTimeIntervalSince1970:(NSTimeInterval)secs format:(NSString *)format;

///反格式化时间字符串为距1970的秒数
+ (NSTimeInterval)deformatTimeString:(NSString *)timeString format:(NSString *)format;

/**
 *  聊天界面使用的时间，描述性的时间
 *
 *  @return NSString
 */
-(NSString*)toChatString;

/**
 *  大概的时间，描述性的时间
 *
 *  @return NSString
 */
-(NSString*)toAboutTimeString;

/**
 *  格式化输出时间
 *
 *  @return NSString
 */
-(NSString*)toString;
-(NSString*)toStringWithFormat:(NSString*)pFormat;
+(NSDate*)dateWithString:(NSString*)pDateString;
+(NSDate*)dateWithString:(NSString*)pDateString format:(NSString*)pFormat;

/**
 *  分别获取年、月、日、时、分、秒
 *
 *  @return NSinteger
 */
-(NSInteger)getYear;
-(NSInteger)getMonth;
-(NSInteger)getDay;
-(NSInteger)getHour;
-(NSInteger)getMinute;
-(NSInteger)getSecond;
-(NSInteger)getWeek;

/**
 *  获取年、月、日、星期 的字符串
 *
 *  @return NSString
 */
-(NSString *)getYearString;
-(NSString *)getMonthString;
-(NSString *)getDayString;
-(NSString *)getWeekString;

/**
 *  获取指定年月的起始日期
 *
 *  @param pYear  年份
 *  @param pMonth 月份
 *
 *  @return NSDate
 */
+(NSDate*)getStartDateWithYear:(int)pYear andMonth:(int)pMonth;

/**
 *  获取指定年月的结束日期
 *
 *  @param pYear  年份
 *  @param pMonth 月份
 *
 *  @return NSDate
 */
+(NSDate*)getEndDateWithYear:(int)pYear andMonth:(int)pMonth;

/**
 *  农历转换函数
 *
 *  @param solarDate  NSDate
 *  @param isShowYear 是否输出年份
 *
 *  @return 农历字符串
 */
+(NSString *)lunarForSolar:(NSDate *)solarDate ShowYear:(BOOL)isShowYear;

/**
 *  判断是不是今天
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isToday;

/**
 *  判断时不是昨天
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isYesterday;

/**
 *  判断是不是同一天
 *
 *  @param date NSDate
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isSameDayWithDate:(NSDate*)date;

@end
