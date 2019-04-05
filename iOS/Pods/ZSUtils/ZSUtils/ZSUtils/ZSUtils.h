//
//  ZSUtils.h
//  MoeMipa
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//
//  最後更新于   2018-04-25

#ifndef ZSUtils_h
#define ZSUtils_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+ZSExtension.h"
#import "UIView+ZSExtension.h"
#import "UIColor+ZSExtension.h"
#import "UIDevice+ZSExtension.h"
#import "UIImage+ZSExtension.h"
#import "UIViewController+ZSExtension.h"
#import "NSObject+ZSExtension.h"
#import "NSDate+ZSExtension.h"
#import "UIScreen+ZSExtension.h"
#import "UIControl+ZSExtension.h"
#import "UIBarButtonItem+ZSExtension.h"
#import "UIButton+ZSExtension.h"
#import "UISegmentedControl+ZSExtension.h"
#import "UITableView+ZSExtension.h"

#define MAIN_COLOR                          [UIColor colorWithHex:@"#e18996"]

#if DEBUG
#define ZSLog(format, ...)                  NSLog((@"%s [Line %d] " format ), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZSLog(format, ...)
#endif

#define ZSWeakify(var)                      __ZSWeak(var, var##_weak_)
#define ZSStrongify(var)                    __ZSStrong(var##_weak_, var)

#define __ZSWeak(var, weakVar)              __weak __typeof__(&*var) weakVar = var
#define __ZSStrong(weakVar, var)            __strong __typeof__(&*weakVar) var = weakVar

#define StringFromInt(value)                [NSString stringWithFormat:@"%d", (int)(value)]
#define StringFromFloat(value)              [NSString stringWithFormat:@"%f", (float)(value)]
#define StringFromDouble(value)             [NSString stringWithFormat:@"%lf", (double)(value)]
#define StringFromBOOL(value)               StringFromInt(value)
#define StringFromUnsignedLongLong(value)   [NSString stringWithFormat:@"%llu", (unsigned long long)(value)]

#define iPad                                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone                              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define ZSColor(r, g, b)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/*宏构造单例代码*/
#define ZS_SINGLE_INSTENCE(_object_name_, _obj_shared_name_) \
static _object_name_ *_##_object_name_ = nil; \
+ (instancetype)_obj_shared_name_ { \
if (!_##_object_name_) { \
@synchronized(self) { \
if (!_##_object_name_) { \
_##_object_name_ = [[[self class] alloc] init]; \
} \
} \
} \
return _##_object_name_; \
} \
+ (id)allocWithZone:(NSZone *)zone { \
@synchronized(self) { \
if (_##_object_name_ == nil) { \
_##_object_name_ = [super allocWithZone:zone]; \
return _##_object_name_; \
} \
} \
return nil; \
} \
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}

/**
 *  返回安全字符串，确保字符串非空，一般用于插入字典前
 *
 *  @param str NSString
 *
 *  @return NSString
 */
#define SAFE_STRING(str)   (((str)&&![(str) isKindOfClass:NSNull.class])?[NSString stringWithFormat:@"%@",(str)]:@"")

#define NELocalizedString(key, comment)     NSLocalizedStringFromTable(key, @"NSDate_extend", comment)

#define KB 1024.0
#define MB (KB * 1024.0)
#define GB (MB * 1024.0)

void asyncTask(id(^backTask)(void), void(^mainTask)(id x));

@interface ZSUtils : NSObject

+ (void)clearCache:(NSString *)path;

+ (unsigned long long)systemFreeSize;

+ (unsigned long long)systemTotalSize;

+ (unsigned long long)fileSizeAtPath:(NSString*)path lowerCaseExtensionRegex:(NSString *)regex;

+ (int)folderCountAtPath:(NSString*)folderPath lowerCaseExtensionRegex:(NSString *)regex;

+ (NSString *)sizeString:(unsigned long long)size;

+ (NSString *)durationString:(int)duration;

/**
 *  随机返回[smallerNumber, largerNumber]范围内的整数
 */
+ (int)randomBetween:(int)smallerNumber And:(int)largerNumber;

/**
 *  随机返回[smallerNumber, largerNumber]范围内的值
 *
 *  @param smallerNumber 最小值
 *  @param largerNumber  最大值
 *  @param digit         小数位数
 *
 *  @return 随机浮点数
 */
+ (float)randomBetween:(float)smallerNumber And:(float)largerNumber Precison:(int)digit;

//获取程序的Home目录路径
+ (NSString *)homeDirectoryDir;

//获取document目录路径
+ (NSString *)documentDir;

//获取Cache目录路径
+ (NSString *)cacheDir;

//获取Library目录路径
+ (NSString *)libraryDir;

//获取Tmp目录路径
+ (NSString *)tmpDir;

// 返回Documents下的指定目录(不存在则创建)
+ (NSString *)directoryInDocuments:(NSString *)dir;

// 返回Caches下的指定目录(不存在则创建)
+ (NSString *)directoryInCaches:(NSString *)dir;

//创建目录文件夹
+ (NSString *)createDir:(NSString *)dir inDir:(NSString *)supDir;

//写入NsArray文件
+ (BOOL)writeArray:(NSArray *)ArrarObject ToFile:(NSString *)path;

//写入NSDictionary文件
+ (BOOL)writeDictionary:(NSMutableDictionary *)DictionaryObject ToFile:(NSString *)path;

//是否存在该文件
+ (BOOL)isFileExists:(NSString *)filepath;

//删除指定文件
+ (void)deleteFile:(NSString *)filepath;

//删除 document/dir 目录下 所有文件
+ (void)deleteAllForDocumentsDir:(NSString *)dir;

//获取目录列表里所有的文件名
+ (NSArray *)filesAtPath:(NSString *)path;

//直接取文件数据
+ (NSData *)dataWithResource:(NSString *)name AtDir:(NSString *) type;
+ (NSData *)dataWithDocuments:(NSString *)name AtDir:(NSString *)dir;
+ (NSData *)dataWithFilePath:(NSString *)path;

//获取文件路径
+ (NSString *)fileWithCaches:(NSString *)filename;
+ (NSString *)fileWithCaches:(NSString *)filename AtDir:(NSString *)dir;

+ (NSString *)fileWithDocuments:(NSString *)filename;
+ (NSString *)fileWithDocuments:(NSString *)filename AtDir:(NSString *)dir;

+ (NSString *)fileWithResource:(NSString *)name;
+ (NSString *)fileWithResource:(NSString *)name AtDir:(NSString *)dir;

@end

#endif
