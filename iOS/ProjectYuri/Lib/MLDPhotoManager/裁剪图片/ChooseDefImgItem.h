//
//  ChooseDefImgItem.h
//  XiaoMaiBu
//
//  Created by sang on 2017/5/16.
//  Copyright © 2017年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDefImgItem : UIButton
@property (nonatomic, copy) NSString * title;
@property (nonatomic,assign) NSInteger photoCount;


+ (instancetype)itemFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
@end
