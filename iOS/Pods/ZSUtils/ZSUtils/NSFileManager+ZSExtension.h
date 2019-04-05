//
//  NSFileManager+ZSExtension.h
//  ZSUtils
//
//  Created by 張帥 on 2018/09/18.
//  Copyright © 2018 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ZSExtension)

/// 获取document目录URL
+ (NSURL *)zs_documentsURL;

/// 获取document目录路径
+ (NSString *)zs_documentsPath;

/// 获取library目录URL
+ (NSURL *)zs_libraryURL;

/// 获取library目录路径
+ (NSString *)zs_libraryPath;

/// 获取caches目录URL
+ (NSURL *)zs_cachesURL;

/// 获取caches目录路径
+ (NSString *)zs_cachesPath;

@end
