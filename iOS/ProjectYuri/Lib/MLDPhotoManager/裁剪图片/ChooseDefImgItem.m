//
//  ChooseDefImgItem.m
//  XiaoMaiBu
//
//  Created by sang on 2017/5/16.
//  Copyright © 2017年 liusang. All rights reserved.
//
#define MaxPhotoCount 3 // 可选总图片数
#import "ChooseDefImgItem.h"

@implementation ChooseDefImgItem
+ (instancetype)itemFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action {
    ChooseDefImgItem * item = [ChooseDefImgItem itemTitle:title target:target action:action];
    item.frame = frame;
    
    return item;
}
+ (instancetype)itemTitle:(NSString *)title target:(id)target action:(SEL)action {
 
    ChooseDefImgItem * item = [[ChooseDefImgItem alloc] init];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont systemFontOfSize:14];
    item.titleLabel.textAlignment = NSTextAlignmentRight;
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return item;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)setPhotoCount:(NSInteger)photoCount {
    _photoCount = photoCount;
    self.title = [NSString stringWithFormat:@"完成(%ld/%d)",(long)photoCount,MaxPhotoCount];
}

@end
