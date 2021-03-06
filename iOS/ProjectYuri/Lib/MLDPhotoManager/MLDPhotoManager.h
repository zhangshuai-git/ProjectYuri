//
//  MLDPhotoManager.h
//  Photo
//
//  Created by Moliy on 2017/3/23.
//  Copyright © 2017年 Moliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGPhoto.h"

@interface MLDPhotoManager : NSObject
@property (nonatomic, assign)NSInteger maxPhotoCount;
/**
 呼出相册控制器

 @param carryView 控制器的发起者(因为如果是iPad需要一个停靠的view,这个sender就是ipad在呼出的View,比如点击了某个Button)
 @param cameraImages 输出相机的单张照片(原图)
 @param albumArray 输出相册中多选的照片数组(原图)
 */
+ (void)showPhotoManager:(UIView *)carryView
         withCameraImages:(void(^)(NSArray *cameraImages))cameraImages
          withAlbumArray:(void(^)(NSArray *albumArray))albumArray;

+ (instancetype)photoManager:(UIView *)carryView
            withCameraImages:(void(^)( NSArray *cameraImages))cameraImages
              withAlbumArray:(void(^)(NSArray *albumArray))albumArray
                 cancelBlock:(void(^)(void))cancelBlock;

- (void)showAlert:(UIView *)view;

@property (nonatomic , copy) void(^cancelBlock)(void);

@end
