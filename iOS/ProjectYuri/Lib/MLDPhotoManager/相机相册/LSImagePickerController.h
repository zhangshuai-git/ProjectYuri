//
//  LSImagePickerController.h
//  cunjian
//
//  Created by mac2 on 16/8/31.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImagePickerBlock)(UIImage *image);

@protocol LSImagePickerDelegate <NSObject>

- (void)returnBackImage:(UIImage *)image;

@end
@interface LSImagePickerController : UIImagePickerController
@property (nonatomic, copy) ImagePickerBlock block;


@property (nonatomic, assign) id <LSImagePickerDelegate> pickerDelegate;


+ (instancetype)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType )sourceType;
// 相机
+ (instancetype)imagePickerControllerWithSourceTypeCamera:(ImagePickerBlock)block;
// 相册
+ (instancetype)imagePickerControllerWithSourceTypePhotoLibrary:(ImagePickerBlock)block;
@end
