//
//  UISegmentedControl+ZSExtension.m
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/26.
//  Copyright © 2019 張帥. All rights reserved.
//

#import "UISegmentedControl+ZSExtension.h"
#import <objc/runtime.h>
#import "UIColor+ZSExtension.h"

static const char *key = "UISEGMENTEDCONTROL_STYLE_ENUM";

@implementation UISegmentedControl (ZSExtension)

- (SegmentedControlStyle)style {
    return [objc_getAssociatedObject(self, &key) intValue];
}

- (void)setStyle:(SegmentedControlStyle)style {
    objc_setAssociatedObject(self, &key, @(style), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    switch (style) {
        case SegmentedControlStyleDefault:break;
        case SegmentedControlStyleClear:{
            //定义选中状态的样式selected
            NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                       NSForegroundColorAttributeName:self.tintColor};
            //定义未选中状态下的样式normal
            NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                     NSForegroundColorAttributeName:[UIColor grayColor]};
            [self setTitleTextAttributes:normal forState:UIControlStateNormal];
            [self setTitleTextAttributes:selected forState:UIControlStateSelected];
            self.tintColor = [UIColor clearColor];
        }break;
    }
}

@end
