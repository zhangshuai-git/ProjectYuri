//
//  UIColor+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIColor+ZSExtension.h"
#import "ZSUtils.h"

@implementation UIColor (ZSExtension)

+ (instancetype)colorWithHex:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [@"ff" stringByAppendingString:cleanString];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float alpha = ((baseValue >> 24) & 0xFF)/255.0f;
    float red = ((baseValue >> 16) & 0xFF)/255.0f;
    float green = ((baseValue >> 8) & 0xFF)/255.0f;
    float blue = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)main {
    return MAIN_COLOR;
}

+ (UIColor *)random {
    CGFloat red = (arc4random() % 255 + 0.5) / 255.0;
    CGFloat green = (arc4random() % 255 + 0.5) / 255.0;
    CGFloat blue = (arc4random() % 255 + 0.5) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

@end
