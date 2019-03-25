//
//  UIView+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZSExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) UIViewController * viewContoller;

/**
 *  保存参数信息
 */
@property (nonatomic, strong) id userInfo;

+ (instancetype)viewWithColor:(UIColor *)color;

/**
 *  清除所有subView
 */
- (void)clearAllSubView;

/**
 *  获取所有subView
 *
 *  @return UIView Array
 */
- (NSArray *)allSubViews;

/**
 *  遍历所有subView取消其焦点,收回键盘
 */
- (void)resignResponder;

@end
