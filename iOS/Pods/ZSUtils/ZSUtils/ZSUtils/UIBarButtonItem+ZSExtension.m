//
//  UIBarButtonItem+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIBarButtonItem+ZSExtension.h"
#import "UIControl+ZSExtension.h"

@implementation UIBarButtonItem (ZSExtension)

- (UIButton *)button {
    if ([self.customView isKindOfClass:UIButton.class]) {
        return self.customView;
    } else {
        return nil;
    }
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image handler:(void(^)(id sender))handler {
    return [self itemWithImage:image higeLightedImage:nil imageEdgeInsets:UIEdgeInsetsZero handler:handler];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                           handler:(void(^)(id sender))handler {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button handleTapWithBlock:handler];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.imageEdgeInsets = imageEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(UIImage *)image {
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3) nomalImage:image higeLightedImage:nil imageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:nil;
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor?highlightedColor:nil forState:UIControlStateHighlighted];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.titleEdgeInsets = titleEdgeInsets;
    button.imageEdgeInsets = imageEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image {
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:UIEdgeInsetsZero];
}
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image {
    return [self itemWithTarget:nil action:nil image:image];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:imageEdgeInsets];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.imageEdgeInsets = imageEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:UIEdgeInsetsZero];
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title {
    return [self itemWithTarget:nil action:nil title:title];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:titleEdgeInsets];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:nil;
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor?highlightedColor:nil forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.titleEdgeInsets = titleEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
