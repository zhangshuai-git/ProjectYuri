//
//  UIDevice+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZSExtension)

/**
 *  获取设备版本信息
 *
 *  @return iPhone1,1
 */
+ (NSString*)platform;

/**
 *  获取设备版本名字
 *
 *  @return iPhone 1G
 */
+ (NSString *)platformString;

/**
 *  app版本
 *
 *  @return app版本
 */
+ (NSString *)appVersion;

/**
 *  app build版本
 *
 *  @return app build版本
 */
+ (NSString *)appBuildVersion;

/**
 *  app名称
 *
 *  @return app名称
 */
+ (NSString *)appName;

/**
 *  获取iOS系统版本号
 */
+ (float)iOSVersion;

@end
