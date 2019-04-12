//
//  UIColor+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZSExtension)

/**
 *  将十六进制的颜色值转为UIColor
 *
 *  @param hexString @"#1ec1a3FF"
 *
 *  @return UIColor
 */
+ (instancetype)colorWithHex:(NSString *)hexString;

@property (class, nonatomic, readonly) UIColor *main;

@property (class, nonatomic, readonly) UIColor *random;

@end
