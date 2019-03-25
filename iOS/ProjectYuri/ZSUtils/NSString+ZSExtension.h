//
//  NSString+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZSExtension)

/// 判断字符串是否为空
+ (BOOL)isEmpty:(NSString *)str;

/// 返回本地化之后的String
@property (nonatomic, readonly, nonnull) NSString *localized;

/// 返回URLEncoded之后的字符串
- (NSString *)urlencodedString;

/// 汉字转拼音
- (NSString *)chineseToPinyin;

/// 汉字转拼音首字母
- (NSString *)chineseToPinyinHead;

/// 字符串中是否包含中文
- (BOOL)isIncludeChinese;

///文件是否为图片
- (BOOL)isPicture;

///文件是否为音频
- (BOOL)isAudio;

/// 文件是否为视频
- (BOOL)isVideo;

/// 判断字符串是否相等，忽略大小写
- (BOOL)isCaseInsensitiveEqualToString:(NSString *)string;

/// string是否匹配正则regex
- (BOOL)isMatches:(NSString *)regex;

/// 匹配由数字、26个英文字母或者下划线组成的字符串, 一般用于用户名, 或密码
-(BOOL)checkUserName;

/**
 *  判断字符串是否为更新版本
 *
 *  @param version  exp：1.0.1 , 1.0.2
 *
 *  @return YES 为新版
 */
- (BOOL)isNewVersion:(NSString *)version;

/**
 *  是否合法email地址
 *
 *  @return YES是
 */
-(BOOL)isValidateEmail;

/**
 *  是否中国手机号码
 *
 *  @return YES是
 */
-(BOOL)isMobileNumber;

/**
 *  是否英文或数字组成
 *
 *  @return YES是
 */
-(BOOL)isAlphabetOrNumber;

/**
 *  是否中文
 *
 *  @return YES是
 */
-(BOOL)isChinese;

/**
 *  是否数字
 *
 *  @return YES是
 */
-(BOOL)isNumber;

/**
 *  是否中文或数字组成
 *
 *  @return YES是
 */
-(BOOL)isChinCharOrNum;

/**
 *  是否中文或英文字母组成
 *
 *  @return YES是
 */
-(BOOL)isChineseOrChar;

/**
 *  是否IP地址
 *
 *  @return YES是
 */
-(BOOL)isIpAddress;

/**
 *  判断self与指定ip是否同一网段
 *
 *  @param ip 需要比较的ip
 *
 *  @return YES表示是同一网段
 */
-(BOOL)isSameSubNetworkWithIP:(NSString *)ip;

/**
 *  判断是否包含Emoji表情
 *
 *  @return YES表示包含
 */
- (BOOL)isHaveEmojiString;

/**
 *  一百以内整数转中文字符串
 *
 *  @param number 100以内整数
 *
 *  @return 中文字符串
 */
+ (NSString *)intToChineseString:(int)number;

/**
 *  url数组参数
 *
 *  @param items 字符串数组
 *
 *  @return 返回拼接好的字符串 exp: 1,2,3,4
 */
+(NSString *)urlArrayParam:(NSArray *)items;

/// 秒数转描述性时间, ex. 3天5小时3分钟
+(NSString *)secondsToDateString:(NSInteger)time;

@end
