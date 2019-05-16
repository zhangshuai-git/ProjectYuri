//
//  LSImagePickerController.m
//  cunjian
//
//  Created by mac2 on 16/8/31.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "LSImagePickerController.h"

@interface LSImagePickerController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation LSImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (instancetype)init {
    if (self = [super init]) {
        
     self.delegate = self;
        
    }
    return self;
}

+ (instancetype)imagePickerControllerWithSourceTypeCamera:(ImagePickerBlock)block {
    
    LSImagePickerController * picker = [[LSImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.block = block;
    return picker;
}
+ (instancetype)imagePickerControllerWithSourceTypePhotoLibrary:(ImagePickerBlock)block {
    LSImagePickerController * picker = [[LSImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.block = block;
    return picker;
}
+ (instancetype)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType )sourceType {
    
    LSImagePickerController * picker = [[LSImagePickerController alloc] init];
   
    picker.sourceType = sourceType;
    return picker;
   
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);  //UIImagePickerControllerMediaType,UIImagePickerControllerOriginalImage,UIImagePickerControllerReferenceURL
    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
    
    if ([mediaType isEqualToString:@"public.image"]) {  //判断是否为图片
       
        UIImage * image = info[UIImagePickerControllerOriginalImage];
//        _showImage = [Tool imageWithImageSimple:[info objectForKey:UIImagePickerControllerOriginalImage] scaledToSize:cell.photoImageV.size];
        if (self.block) {
            self.block(image);
        }
        
        if ([self.pickerDelegate respondsToSelector:@selector(returnBackImage:)]) {
            [self.pickerDelegate returnBackImage:image];
        }
       
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
