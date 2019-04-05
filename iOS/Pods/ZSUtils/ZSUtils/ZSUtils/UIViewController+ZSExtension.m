//
//  UIViewController+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIViewController+ZSExtension.h"
#import "ZSUtils.h"

@implementation UIViewController (ZSExtension)

- (void)setLeftBarButtonItem:(UIBarButtonItem *)BarButtonItem {
    [self setBarButtonItem:BarButtonItem isRight:NO];
}
- (void)setRightBarButtonItem:(UIBarButtonItem *)BarButtonItem {
    [self setBarButtonItem:BarButtonItem isRight:YES];
}
- (void)setBarButtonItem:(UIBarButtonItem *)_BarButtonItem isRight:(BOOL)isRight {
    
    UINavigationItem *navigationItem = [self currentNavigationItem];
    
    if (/* DISABLES CODE */ (0) && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -12;
        
        if (_BarButtonItem) {
            if (isRight) {
                navigationItem.rightBarButtonItems = @[negativeSeperator, _BarButtonItem];
            } else {
                navigationItem.leftBarButtonItems = @[negativeSeperator, _BarButtonItem];
            }
        } else {
            if (isRight) {
                navigationItem.rightBarButtonItems = @[negativeSeperator];
            } else {
                navigationItem.leftBarButtonItems = @[negativeSeperator];
            }
        }
    } else {
        if (isRight) {
            navigationItem.rightBarButtonItem = _BarButtonItem;
        } else {
            navigationItem.leftBarButtonItem = _BarButtonItem;
        }
    }
}

- (UIBarButtonItem *)leftBarButtonItem {
    return [self getBarButtonItemIsRight:NO];
}
- (UIBarButtonItem *)rightBarButtonItem {
    return [self getBarButtonItemIsRight:YES];
}
- (UIBarButtonItem *)getBarButtonItemIsRight:(BOOL)isRight {
    UIBarButtonItem *barButtonItem = nil;
    UINavigationItem *navigationItem = [self currentNavigationItem];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        if (isRight) {
            barButtonItem = [navigationItem.rightBarButtonItems lastObject];
        } else {
            barButtonItem= [navigationItem.leftBarButtonItems lastObject];
        }
    } else {
        if (isRight) {
            barButtonItem = navigationItem.rightBarButtonItem;
        } else {
            barButtonItem = navigationItem.leftBarButtonItem;
        }
    }
    return barButtonItem;
}

- (void)setTitleView:(UIView *)titleView {
    UINavigationItem *navigationItem = [self currentNavigationItem];
    navigationItem.titleView = titleView;
}
- (UIView *)titleView {
    return [self currentNavigationItem].titleView;
}

- (UINavigationItem *)currentNavigationItem {
    UINavigationItem *navigationItem;
    
    if (!self.tabBarController || [self.tabBarController.viewControllers[0] isKindOfClass:[UINavigationController class]]) {
        /*
         * NavigationController -> self 或者
         * TabBarController -> NavigationController -> self
         * 上方的Item是:self.navigationItem
         */
        navigationItem = self.navigationItem;
    } else {
        /*
         * NavigationController -> TabBarController -> self
         * 上方的Item是:self.tabBarController.navigationItem
         */
        navigationItem = self.tabBarController.navigationItem;
    }
    return navigationItem;
}

@end
