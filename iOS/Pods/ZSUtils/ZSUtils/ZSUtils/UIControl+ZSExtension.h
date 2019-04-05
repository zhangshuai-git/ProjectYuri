//
//  UIControl+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZSExtension)

- (void)handleTapWithBlock:(void(^)(id sender))block;
- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(void(^)(id sender))block;

@end
