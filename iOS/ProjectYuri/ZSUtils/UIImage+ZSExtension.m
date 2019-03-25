//
//  UIImage+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "UIImage+ZSExtension.h"
#import "ZSUtils.h"

@implementation UIImage (ZSExtension)

+ (UIImage *)imageWithName:(NSString *)name {
    // iOS7 以后
    if ([UIDevice iOSVersion] >= 7.0) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) { // 没有_os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    // iOS6
    return [UIImage imageNamed:name];
}

/**
 *  拉伸图片的中点(.9.png)
 *
 *  @param name 图片名
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name {
    UIImage *normal = [UIImage imageWithName:name];
    return [normal resizedImage];
}

/**
 *  拉伸图片的中点(.9.png)
 */
- (UIImage *)resizedImage {
    return [self resizedImageAtLeft:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageWithName:name];
    return [image resizedImageAtLeft:left top:top];
}

- (UIImage *)resizedImageAtLeft:(CGFloat)left top:(CGFloat)top {
    CGFloat t = self.size.height * top;
    CGFloat l = self.size.width * left;
    CGFloat b = self.size.height * (1-t);
    CGFloat r = self.size.width * (1-l);
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(t, l, b, r)];
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}

+ (UIImage *)stretchableImageWithName:(NSString *)name {
    UIImage *normal = [UIImage imageWithName:name];
    return [normal stretchableImage];
}

- (UIImage *)stretchableImage {
    return [self stretchableImageAtLeft:0.5 top:0.5];
}

+ (UIImage *)stretchableImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageAtLeft:left top:top];
}

- (UIImage *)stretchableImageAtLeft:(CGFloat)left top:(CGFloat)top {
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}

/**
 *  使用颜色生成1*1的图像
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+ (UIImage *)imageWithGIFData:(NSData *)data
{
    if (!data) return nil;
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            //Learning... 设置动画时长 算出每一帧显示的时长（帧时长）
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            duration += frameDuration;
            
            // 将每帧图片添加到数组中
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            // 释放真图片对象
            CFRelease(image);
        }
        
        // 设置动画时长
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    // 释放源Gif图片
    CFRelease(source);
    
    return animatedImage;
}

+ (UIImage *)imageWithGIFNamed:(NSString *)name
{
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    return [self GIFName:name scale:scale];
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    
    if (!imagePath) {
        
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    
    if (imagePath) {
        
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithGIFData:imageData];
        
    } else {
        
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        if (imagePath) {
            
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage imageWithGIFData:imageData];
        } else {
            
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}

+ (void)imageWithGIFUrl:(NSString *)url and:(void(^)(UIImage *GIFImage))gifImageBlock
{
    NSURL *GIFUrl = [NSURL URLWithString:url];
    
    if (!GIFUrl) return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *CIFData = [NSData dataWithContentsOfURL:GIFUrl];
        
        // 刷新UI在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            gifImageBlock([UIImage imageWithGIFData:CIFData]);
        });
    });
    
}

#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

/**
 *  截取当前屏幕
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  截取当前屏幕内容
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot {
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

/**
 *  截取部分图像，包括旋转
 *
 *  @param rect 截取区域
 *
 *  @return 截取出来的UIImage对象
 */
- (UIImage *)imageAtRect:(CGRect)rect {
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    // 设置图片旋转方向
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1.0f orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return smallImage;
}

/**
 *  生成重新调整大小的图像
 *
 *  @param reSize 新大小
 *
 *  @return UIImage
 */
- (UIImage *)imageResize:(CGSize)reSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/**
 *  生成等比例缩放图片
 *
 *  @param scale 缩放比例
 *
 *  @return 缩放后的UIImage对象
 */
- (UIImage *)imageToScale:(CGFloat)scale {
    return [self imageResize:CGSizeMake(self.size.width * scale, self.size.height * scale)];
}

- (UIImage *)autoScaleWithMaxLength:(CGFloat)maxLength {
    
    CGFloat max = MAX(self.size.width, self.size.height);
    CGFloat scale = 1;
    
    if (max > maxLength) {
        scale = maxLength / max;
    }
    
    return [self imageToScale:scale];
}

/**
 *  保存UIImage对象到文件，jpg、png，通过路径文件后缀名保存格式
 *
 *  @param aPath 保存的绝对路径
 *
 *  @return 保存成功返回YES
 */
- (BOOL)writeToFile:(NSString *)aPath {
    if ((self == nil) || (aPath == nil) || ([aPath isEqualToString:@""])) return NO;
    @try
    {
        NSData *imageData = nil;
        NSString *ext = aPath.pathExtension.lowercaseString;
        if ([ext isEqualToString:@"png"]) {
            imageData = UIImagePNGRepresentation(self);
        } else {
            // the rest, we write to jpeg
            // 0. best, 1. lost. about compress.
            imageData = UIImageJPEGRepresentation(self, 1.0);
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}

@end
