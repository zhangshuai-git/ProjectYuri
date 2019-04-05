//
//  NSObject+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZSExtension)

/**
 *  本地对象序列化成json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  本地对象序列化成json数据流
 *
 *  @return json数据流
 */
- (NSData *)JSONData;

/**
 *  json格式的 NSData 或 NSString 解析成本地对象
 *
 *  @return 本地对象
 */
- (id)objectFromJSON;

/**
 *  获取程序编译时间
 *
 *  @return NSDate
 */
+ (NSDate *)buildDate;

/**
 *  检测测试包超时
 *
 *  *** 记得重新编译，避免编译缓存 ***
 *
 *  @param time           测试的时间长度（从编译日期开始）(单位s), 设置为0时可以永久使用
 *  @param timeoutTitle   超时后弹出UIAlertView的title
 *  @param timeoutMessage 超时后弹出UIAlertView的message
 *
 *  @return 测试包是否超时
 */
+ (BOOL)checkTestTime:(NSTimeInterval)time timeoutTitle:(NSString *)timeoutTitle timeoutMessage:(NSString *)timeoutMessage;


/**
 交换两个对象方法的实现

 @param originalSEL 原方法
 @param swizzledSEL 用来替换的方法
 */
+ (void)swizzlingInstanceMethodForm:(SEL)originalSEL to:(SEL)swizzledSEL;

/**
 交换两个类方法的实现
 
 @param originalSEL 原方法
 @param swizzledSEL 用来替换的方法
 */
+ (void)swizzlingClassMethodForm:(SEL)originalSEL to:(SEL)swizzledSEL;

@end
