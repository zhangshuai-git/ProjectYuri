//
//  MLDPhotoManager.m
//  Photo
//
//  Created by Moliy on 2017/3/23.
//  Copyright © 2017年 Moliy. All rights reserved.
//
#define MaxPhotoCount 3 // 最打连拍张数、最大相册照片数
#import "MLDPhotoManager.h"
#import "LKActionSheetView.h"
#import "LSImagePickerController.h"
#import "UIView+ZSExtension.h"

@interface MLDPhotoManager ()<LGPhotoPickerBrowserViewControllerDataSource,LGPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, assign) LGShowImageType showType;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserPhotoArray;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserURLArray;
@property (nonatomic,copy)void(^CameraImage)(UIImage *cameraImage);
@property (nonatomic,copy)void(^CameraImages)(NSArray *cameraImages);
@property (nonatomic,copy)void(^AlbumArray)(NSArray *albumArray);
@property (nonatomic, strong) UIView * vcView;


@end

@implementation MLDPhotoManager


+ (instancetype)photoManager:(UIView *)carryView
            withCameraImages:(void(^)(NSArray *cameraImages))cameraImages
              withAlbumArray:(void(^)(NSArray *albumArray))albumArray
                 cancelBlock:(void(^)(void))cancelBlock
{
    MLDPhotoManager *objct = [[MLDPhotoManager alloc] init];
    objct.AlbumArray = albumArray;
    objct.CameraImages = cameraImages;
    objct.vcView = carryView;
    objct.cancelBlock = cancelBlock;
    return objct;
}
+ (void)showPhotoManager:(UIView *)carryView
        withCameraImages:(void(^)( NSArray *cameraImages))cameraImages
          withAlbumArray:(void(^)(NSArray *albumArray))albumArray
{
    MLDPhotoManager *objct = [[MLDPhotoManager alloc] init];
    objct.AlbumArray = albumArray;
    objct.CameraImages = cameraImages;
    objct.vcView = carryView;
    [objct showAlert:carryView];
}

#pragma mark - 懒加载

- (NSMutableArray *)LGPhotoPickerBrowserPhotoArray
{
    if (!_LGPhotoPickerBrowserPhotoArray)
    {
        _LGPhotoPickerBrowserPhotoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _LGPhotoPickerBrowserPhotoArray;
}

- (NSMutableArray *)LGPhotoPickerBrowserURLArray
{
    if (!_LGPhotoPickerBrowserURLArray)
    {
        _LGPhotoPickerBrowserURLArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _LGPhotoPickerBrowserURLArray;
}

#pragma mark - setupUI

- (void)showAlert:(UIView *)view
{
    [LKActionSheetView sheetWithAlertTitle:@"请选择" title1:@"相机" title2:@"相册" lkActionItem1:^(LKActionItem * item1) {
        [[LKActionSheetView defaultActionSheetView] hide];
        if (![MLDPhotoManager IsExistCamera]) {
            return ;
        }
        [self presentCameraSingle]; // 相机
        
       
    } lkActionItem2:^(LKActionItem *item2) {
        [[LKActionSheetView defaultActionSheetView] hide];
        [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
    }];
    
   
}

/**
 *  初始化相册选择器
 */
- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style
{
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = self.maxPhotoCount?self.maxPhotoCount:MaxPhotoCount;   // 最多能选x张图片
    pickerVc.cancelBlock = self.cancelBlock;
    pickerVc.callBack = ^(NSArray *assets)
    {
//        NSMutableArray *thumbImageArray = [NSMutableArray array];
        NSMutableArray *originImageArray = [NSMutableArray array];
//        NSMutableArray *compressionImageArray = [NSMutableArray array];
//        NSMutableArray *fullResolutionImageArray = [NSMutableArray array];
//        for (LGPhotoAssets *photo in assets)
//        {
//            //缩略图
//            [thumbImageArray addObject:photo.thumbImage];
//            //原图
//            [originImageArray addObject:photo.originImage];
//            //全屏图
//            [fullResolutionImageArray addObject:photo.fullResolutionImage];
//            //压缩图片
//            [compressionImageArray addObject:photo.compressionImage];
//        }
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LGPhotoAssets *photo = obj;
            //缩略图
//            [thumbImageArray addObject:photo.thumbImage];
            //原图
            [originImageArray addObject:photo.originImage];
            //全屏图
//            [fullResolutionImageArray addObject:photo.fullResolutionImage];
            //压缩图片
//            [compressionImageArray addObject:photo.compressionImage];
        }];
        
        self.AlbumArray(originImageArray);
    };
    self.showType = style;
    [pickerVc showPickerVc:[self getCurrentVC]];
}

/**
 *  初始化自定义相机（单拍）
 */
- (void)presentCameraSingle
{
    ZLCameraViewController *cameraVC = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVC.maxCount = self.maxPhotoCount?self.maxPhotoCount:MaxPhotoCount;
    // 单拍
    cameraVC.cameraType = ZLCameraContinuous;
    cameraVC.callback = ^(NSArray *cameras)
    {
        NSMutableArray * array = [NSMutableArray array];
        [cameras enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZLCamera * photo = obj;
            [array addObject:photo.photoImage];
        }];
//        ZLCamera *canamerPhoto = cameras[0];
//        UIImage *image = canamerPhoto.photoImage;
        self.CameraImages(array);
    };
    [cameraVC showPickerVc:[self getCurrentVC]];
}

- (UIViewController *)getCurrentVC
{
//    UIViewController *result = nil;
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    result = window.rootViewController;
//    return result;
    return self.vcView.viewController;
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource

- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser
   numberOfItemsInSection:(NSUInteger)section
{
    if (self.showType == LGShowImageTypeImageBroswer)
    {
        return self.LGPhotoPickerBrowserPhotoArray.count;
    }
    else if (self.showType == LGShowImageTypeImageURL)
    {
        return self.LGPhotoPickerBrowserURLArray.count;
    }
    else
    {
        NSLog(@"非法数据源");
        return 0;
    }
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser
                             photoAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showType == LGShowImageTypeImageBroswer)
    {
        return [self.LGPhotoPickerBrowserPhotoArray objectAtIndex:indexPath.item];
    }
    else if (self.showType == LGShowImageTypeImageURL)
    {
        return [self.LGPhotoPickerBrowserURLArray objectAtIndex:indexPath.item];
    }
    else
    {
        NSLog(@"非法数据源");
        return nil;
    }
}

+ (BOOL )IsExistCamera {
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) { //若不可用，弹出警告框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无可用摄像头" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

@end
