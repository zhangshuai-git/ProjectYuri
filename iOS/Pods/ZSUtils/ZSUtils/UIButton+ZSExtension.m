//
//  UIButton+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIButton+ZSExtension.h"
#import "ZSUtils.h"

@implementation UIButton (ZSExtension)

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *pressedColorImg = [UIImage imageWithColor:color];
    [self setBackgroundImage:pressedColorImg forState:state];
}

@end
