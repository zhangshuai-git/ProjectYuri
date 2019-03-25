//
//  UIScreen+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIScreen+ZSExtension.h"

@implementation UIScreen (ZSExtension)

+ (CGFloat)getScreenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)getScreenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)getScreenMinLength {
    return MIN([self getScreenWidth], [self getScreenHeight]);
}

+ (CGFloat)getScreenMaxLength {
    return MAX([self getScreenWidth], [self getScreenHeight]);
}

@end
