//
//  CropImageViewController.h
//  ImageTailor
//
//  Created by yinyu on 15/10/10.
//  Copyright © 2015年 yinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropImageViewController : UIViewController
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, copy) void(^coredBlock)(NSArray * images);
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (strong, nonatomic) NSNumber *proportion; // 裁剪比例
@property (weak, nonatomic) IBOutlet UIButton *cropBtn;
@property (weak, nonatomic) IBOutlet UILabel *navRightItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

+ (instancetype)coreImages:(NSArray *)images
                proportion:(NSNumber *)proportion
         coreComplainBlock:(void(^)(NSArray * images))coredBlock
               cancelBlick:(void(^)(void))cancelBlock;

- (IBAction)cropClick:(UIButton *)sender;
@end
