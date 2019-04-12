//
//  AlertLabel.m
//  jiaduobao
//
//  Created by zhaoxiaoling on 16/9/26.
//  Copyright © 2016年 zhaoxiaoling. All rights reserved.
//

#import "AlertLabel.h"


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation AlertLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
//        self.font = [UIFont fontWithName:@"FZLanTingHei-L-GBK" size:11];
    }
    return self;
}

+ (instancetype)alertLabelShowInView:(UIView *)superView WithTitle:(NSString *)title
{
    for(UIView *subView in superView.subviews){
        if ([subView isKindOfClass:[AlertLabel class]]) {
            [subView removeFromSuperview];
        }
    }
    CGFloat width = superView.frame.size.width;
    AlertLabel *hud = [[self alloc]initWithFrame:CGRectMake((SCREEN_WIDTH / 2 - 65), SCREEN_HEIGHT - 49 - 30, 130, 40)];
    CGPoint center = CGPointMake(SCREEN_WIDTH / 2, 0.8 * SCREEN_HEIGHT);
    hud.center = center;
    hud.backgroundColor = [UIColor blackColor];
    hud.textColor = [UIColor whiteColor];
    hud.text = title;
    hud.font = [UIFont systemFontOfSize:13.0f];
    hud.alpha = 0;
    [superView addSubview:hud];
    CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    if (size.width > width - 60) {
        hud.numberOfLines = 0;
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(width - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        hud.bounds = CGRectMake(0, 0, width - 60, titleSize.height + 20);
//        hud.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.9);
    }else if (size.width>130)
    {
        hud.bounds = CGRectMake(0, 0, size.width+20, 40);
    }
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    hud.transform = transform;
    [UIView animateWithDuration:0.3 delay:0.1  usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        hud.alpha = 1;
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 delay:0.1  usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            hud.alpha = 0;
            hud.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    });
    return hud;
}

@end
