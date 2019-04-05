//
//  UIControl+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIControl+ZSExtension.h"
#import <objc/runtime.h>

static const char *key = "UICONTROL_ACTION_BLOCK";

@implementation UIControl (ZSExtension)

- (void)handleTapWithBlock:(void (^)(id))block {
    [self handleControlEvents:UIControlEventTouchUpInside withBlock:block];
}

- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(void(^)(id sender))block {
    self.actionBlock = block;
    [self addTarget:self action:@selector(controlEvenAction:) forControlEvents:controlEvents];
}

- (void (^)(id))actionBlock {
    return objc_getAssociatedObject(self, &key);
}

- (void)setActionBlock:(void (^)(id))actionBlock {
    objc_setAssociatedObject(self, &key, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)controlEvenAction:(id)x {
    if (self.actionBlock) self.actionBlock(self);
}

@end
