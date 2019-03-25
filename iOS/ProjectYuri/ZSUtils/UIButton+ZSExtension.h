//
//  UIButton+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZSExtension)

- (NSString *)title;

- (void)setTitle:(NSString *)title;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
