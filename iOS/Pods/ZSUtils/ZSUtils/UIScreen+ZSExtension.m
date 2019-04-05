//
//  UIScreen+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIScreen+ZSExtension.h"

@implementation UIScreen (ZSExtension)

+ (CGFloat)width {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)height {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)minLength {
    return MIN([self width], [self height]);
}

+ (CGFloat)maxLength {
    return MAX([self width], [self height]);
}

@end
