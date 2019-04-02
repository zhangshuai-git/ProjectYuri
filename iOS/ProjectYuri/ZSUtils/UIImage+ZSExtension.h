//
//  UIImage+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZSExtension)

/**
 *  拉伸图片的中点(.9.png)
 *
 *  @param name 图片名
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  拉伸图片的中点(.9.png)
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)resizedImage;

/**
 *  拉伸图片
 *
 *  @param name 图片名
 *  @param left 拉伸点的横坐标，范围：[0,1]
 *  @param top  拉伸点的纵坐标，范围：[0,1]
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  拉伸图片
 *
 *  @param left 拉伸点的横坐标，范围：[0,1]
 *  @param top  拉伸点的纵坐标，范围：[0,1]
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)resizedImageAtLeft:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)stretchableImageWithName:(NSString *)name;

- (UIImage *)stretchableImage;

+ (UIImage *)stretchableImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

- (UIImage *)stretchableImageAtLeft:(CGFloat)left top:(CGFloat)top;

/**
 *  使用颜色生成1*1的图像
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url and:(void(^)(UIImage *GIFImage))gifImageBlock;

/**
 *  截取当前屏幕内容
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot;

/**
 *  截取部分图像，包括旋转
 *
 *  @param rect 截取区域
 *
 *  @return 截取出来的UIImage对象
 */
- (UIImage *)imageAtRect:(CGRect)rect;

/**
 *  生成重新调整大小的图像
 *
 *  @param reSize 新大小
 *
 *  @return UIImage
 */
- (UIImage *)imageResize:(CGSize)reSize;

/**
 *  生成等比例缩放图片
 *
 *  @param scale 缩放比例
 *
 *  @return 缩放后的UIImage对象
 */
- (UIImage *)imageToScale:(CGFloat)scale;


/**
 *  限制图片的最大长度,自动将最长边限制在maxLength之内，另一个边等比缩放
 *
 *  @param maxLength 最长边
 *
 *  @return UIImage
 */
- (UIImage *)autoScaleWithMaxLength:(CGFloat)maxLength;

/**
 *  保存UIImage对象到文件，jpg、png，通过路径文件后缀名保存格式
 *
 *  @param aPath 保存的绝对路径
 *
 *  @return 保存成功返回YES
 */
- (BOOL)writeToFile:(NSString *)aPath;

@end
