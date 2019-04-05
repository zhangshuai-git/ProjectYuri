//
//  UIScreen+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ZSExtension)

@property (class, nonatomic, assign, readonly) CGFloat width;
@property (class, nonatomic, assign, readonly) CGFloat height;
@property (class, nonatomic, assign, readonly) CGFloat minLength;
@property (class, nonatomic, assign, readonly) CGFloat maxLength;

@end
