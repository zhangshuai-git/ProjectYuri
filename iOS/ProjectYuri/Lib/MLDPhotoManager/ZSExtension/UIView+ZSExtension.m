//
//  UIView+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIView+ZSExtension.h"
#import <objc/runtime.h>
#import "ZSUtils.h"

static const char* IndexPathKey ="UIView_UserInfo";

@implementation UIView (PhotoManager)

+ (instancetype)viewWithColor:(UIColor *)color {
    UIView *view = [[self alloc] init];
    view.backgroundColor = color;
    return view;
}

- (void)setUserInfo:(NSIndexPath *)userInfo {
    objc_setAssociatedObject(self, &IndexPathKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return (id)objc_getAssociatedObject(self,IndexPathKey);
}

- (void)setFilletRadius:(CGFloat)filletRadius {
    self.layer.cornerRadius = filletRadius;
    self.clipsToBounds = YES;
}

- (void)clearAllSubView {
    for (UIView *subView in [self subviews]) {
        if ([[subView subviews] count] > 0) {
            for (UIView *s in [subView subviews]) {
                [s clearAllSubView];
            }
        }
        [subView removeFromSuperview];
    }
}
- (NSArray *)allSubViews {
    NSMutableArray *items = [NSMutableArray array];
    for (UIView *v in [self subviews]) {
        [items addObject:v];
        if ([[v subviews] count] > 0) {
            [items addObjectsFromArray:[v allSubViews]];
        }
    }
    return [NSArray arrayWithArray:items];
}

- (void)resignResponder {
    if ([self isKindOfClass:[UITextField class]]) {
        [(UITextField *)self resignFirstResponder];
    }
    if ([self isKindOfClass:[UITextView class]]) {
        [(UITextView *)self resignFirstResponder];
    }
    if ([[self subviews] count] > 0) {
        for (UIView *v in [self subviews]) {
            [v resignResponder];
        }
    }
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setViewController:(UIViewController *)viewController {
    self.viewController = viewController;
}
- (UIViewController *)viewController {
    for (UIView * view = self; view; view = view.superview) {
        UIResponder * nextRextponder = [view nextResponder];
        if ([nextRextponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextRextponder;
        }
    }
    return nil;
}

- (CGSize)layoutSize {
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

+ (void)load {
    SEL layoutSubviews = @selector(layoutSubviews);
    SEL zs_layoutSubviews = @selector(zs_layoutSubviews);
    [self swizzlingClassMethodForm:layoutSubviews to:zs_layoutSubviews];
}

- (void)zs_layoutSubviews {
    [self zs_layoutSubviews];
    
    ZSLog(@"替换后的layoutSubviews");
}


@end
