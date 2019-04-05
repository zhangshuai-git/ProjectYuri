//
//  UISegmentedControl+ZSExtension.h
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/26.
//  Copyright © 2019 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SegmentedControlStyle) {
    SegmentedControlStyleDefault,
    SegmentedControlStyleClear,
};

@interface UISegmentedControl (ZSExtension)

@property (nonatomic, assign) SegmentedControlStyle style;

@end

NS_ASSUME_NONNULL_END
