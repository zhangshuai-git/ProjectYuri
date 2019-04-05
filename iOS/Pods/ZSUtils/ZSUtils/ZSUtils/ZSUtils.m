//
//  ZSUtils.m
//  MoeMipa
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//
//  最後更新于   2015-10-10

#import "ZSUtils.h"
#import <objc/runtime.h>

void asyncTask(id(^backTask)(void), void(^mainTask)(id x)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id x = nil;
        if (backTask) {
            x = backTask();
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (mainTask) {
                mainTask(x);
            }
        });
    });
}

@implementation ZSUtils

//func asyncTask(inBackground backTaskArray: Array<() -> Any?>, mainTask: @escaping (Array<Any?>) -> Void) {
//    let dispatchGroup = DispatchGroup()
//    var resultDict = Dictionary<Int, Any?>()
//    for i in 0..<backTaskArray.count {
//        let backTask: () -> Any? = backTaskArray[i]
//        DispatchQueue.global(qos: .default).async(group:dispatchGroup, execute: {
//            resultDict[i] = backTask()
//        })
//    }
//    dispatchGroup.notify(queue: DispatchQueue.main, execute:{
//        var resultArray = Array<Any?>()
//        for key in resultDict.keys.sorted() {
//            resultArray.append(resultDict[key] ?? nil)
//        }
//        mainTask(resultArray)
//    })
//}

/// 删除单个文件或文件夹内所有文件, 但不会删除文件夹
+ (void)clearCache:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&isDir];
    if (!exist) return;
    if (isDir) {
        NSArray *array = [manager contentsOfDirectoryAtPath:path error:nil];
        for(NSString *fileName in array) {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            [self clearCache:fileAbsolutePath];
        }
    } else {
        [manager removeItemAtPath:path error:nil];
    }
}

/// 系统剩余空间
+ (unsigned long long)systemFreeSize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    return [freeSpace unsignedLongLongValue];
}

/// 系统总空间
+ (unsigned long long)systemTotalSize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    return [totalSpace unsignedLongLongValue];
}

/// 单个文件或者文件夹内所有后缀名转成小写后匹配regex的文件的总大小, regex为空时统计所有文件大小
+ (unsigned long long)fileSizeAtPath:(NSString*)path lowerCaseExtensionRegex:(NSString *)regex {
    unsigned long long folderSize = 0;
    NSFileManager* manager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&isDir];
    if (!exist) return 0;
    if (isDir) {
        NSArray *array = [manager contentsOfDirectoryAtPath:path error:nil];
        for(NSString *fileName in array) {
            NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath lowerCaseExtensionRegex:regex];
        }
        return folderSize;
    } else {
        if (regex && ![[[path pathExtension] lowercaseString] isMatches:regex]) return 0;
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
}

/// 文件夹内后缀名转成小写后匹配regex的文件的个数, regex为空时统计所有文件个数
+ (int)folderCountAtPath:(NSString*)folderPath lowerCaseExtensionRegex:(NSString *)regex {
    int count = 0;
    NSArray *fileNames = [self filesAtPath:folderPath];
    if (!regex) {
        count = (int)fileNames.count;
    } else {
        for (NSString *fileName in fileNames) {
            if ([[[fileName pathExtension] lowercaseString] isMatches:regex]) {
                count++;
            }
        }
    }
    return count;
}

/// 将size(bytes)转换为String
+ (NSString *)sizeString:(unsigned long long)size {
    NSString *s = nil;
    NSString *l = nil;
    
    if (size < KB) {
        l = [NSString stringWithFormat:@"%d", (int)size];
        s = @"Bytes";
    } else if (size >= KB && size <= MB) {
        l = [NSString stringWithFormat:@"%.1f", (double)(size / KB)];
        s = @"KB";
    } else if (size >= MB && size <= GB) {
        l = [NSString stringWithFormat:@"%.1f", (double)(size / MB)];
        s = @"MB";
    } else {
        l = [NSString stringWithFormat:@"%.1f", (double)(size / GB)];
        s = @"GB";
    }
    
    return [NSString stringWithFormat:@"%@%@", l, s];
}

/// 将duration(s)转换为String
+ (NSString *)durationString:(int)duration {
    int t = duration;
    int h = (t / 3600);
    int m = (t % 3600) / 60;
    int s = t % 60;
    
    if (h > 99) {
        return [NSString stringWithFormat:@"%d:%02d:%02d", h, m, s];
    } else {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
    }
}

/**
 *  随机返回[smallerNumber, largerNumber]范围内的整数
 */
+ (int)randomBetween:(int)smallerNumber And:(int)largerNumber{
    return (int)[self randomBetween:smallerNumber And:largerNumber Precison:0];
}

/**
 *  随机返回[smallerNumber, largerNumber]范围内的值
 *
 *  @param smallerNumber 最小值
 *  @param largerNumber  最大值
 *  @param digit         小数位数
 *
 *  @return 随机浮点数
 */
+ (float)randomBetween:(float)smallerNumber And:(float)largerNumber Precison:(int)digit {
    //设置精确的位数
    int precision = pow(10, digit);
    //先取得他们之间的差值
    float subtraction = largerNumber - smallerNumber;
    //取绝对值
    subtraction = ABS(subtraction);
    //乘以精度的位数
    subtraction *= precision;
    //在差值间随机
    float randomNumber = arc4random() % ((int)subtraction+1);
    //随机的结果除以精度的位数
    randomNumber /= precision;
    //将随机的值加到较小的值上
    float result = MIN(smallerNumber, largerNumber) + randomNumber;
    //返回结果
    return result;
}

/**
 * 获取程序的Home目录路径
 */
+ (NSString *)homeDirectoryDir {
    return NSHomeDirectory();
}
/**
 * 获取document目录路径
 */
+ (NSString *)documentDir {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
/**
 * 获取Cache目录路径
 */
+ (NSString *)cacheDir {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
/**
 * 获取Library目录路径
 */
+ (NSString *)libraryDir {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
/**
 * 获取Tmp目录路径
 */
+ (NSString *)tmpDir {
    return NSTemporaryDirectory();
}
/**
 * 返回Documents下的指定目录(不存在则创建)
 */
+ (NSString *)directoryInDocuments:(NSString *)dir {
    //    NSError* error;
    //    NSString* path = [[self documentDir] stringByAppendingPathComponent:dir];
    //    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
    //        NSLog(@"create dir error: %@",error.debugDescription);
    //    }
    //    return path;
    return [self createDir:dir inDir:[self documentDir]];
}
/**
 * 返回Caches下的指定目录(不存在则创建)
 */
+ (NSString *)directoryInCaches:(NSString *)dir {
    //    NSError* error;
    //    NSString* path = [[self cacheDir] stringByAppendingPathComponent:dir];
    //
    //    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
    //        NSLog(@"create dir error: %@",error.debugDescription);
    //    }
    //    return path;
    return [self createDir:dir inDir:[self cacheDir]];
}
/**
 * 创建目录文件夹
 */
+ (NSString *)createDir:(NSString *)dir inDir:(NSString *)supDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [supDir stringByAppendingPathComponent:dir];
    if ([self isFileExists:directory]) {
        //        NSLog(@"Directory already exists: %@",directory);
    } else {
        NSError* error;
        if (![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Can not create directory: %@  error: %@", directory, error.debugDescription);
        }
    }
    return directory;
}
/**
 * 写入NSArray文件
 */
+ (BOOL)writeArray:(NSArray *)ArrarObject ToFile:(NSString *)path {
    return [ArrarObject writeToFile:path atomically:YES];
}
/**
 * 写入NSDictionary文件
 */
+ (BOOL)writeDictionary:(NSMutableDictionary *)DictionaryObject ToFile:(NSString *)path {
    return [DictionaryObject writeToFile:path atomically:YES];
}
/**
 * 是否存在该文件
 */
+ (BOOL)isFileExists:(NSString *)filepath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}
/**
 * 删除指定文件/文件夹
 */
+ (void)deleteFile:(NSString *)filepath {
    if([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    }
}
/**
 * 获取目录列表里所有的文件名
 */
+ (NSArray *)filesAtPath:(NSString *)path {
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *file = [fileManage subpathsAtPath:path];
    return file;
}
+ (void)deleteAllForDocumentsDir:(NSString *)dir {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:[self directoryInDocuments:dir] error:nil];
    for (NSString* filename in fileList) {
        [fileManager removeItemAtPath:[self fileWithDocuments:filename AtDir:dir] error:nil];
    }
}


#pragma mark- 获取文件的数据
+ (NSData *)dataWithFilePath:(NSString *)path {
    return [[NSFileManager defaultManager] contentsAtPath:path];
}
+ (NSData *)dataWithResource:(NSString *)name AtDir:(NSString *)dir {
    return [self dataWithFilePath:[self fileWithResource:name AtDir:dir]];
}
+ (NSData *)dataWithDocuments:(NSString *)name AtDir:(NSString *)dir {
    return [self dataWithFilePath:[self fileWithDocuments:name AtDir:dir]];
}



#pragma mark- 获取文件路径
+ (NSString *)fileWithResource:(NSString *)name {
    return [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
}
+ (NSString *)fileWithResource:(NSString *)name AtDir:(NSString *)dir {
    return [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:dir] stringByAppendingPathComponent:name];
}
+ (NSString *)fileWithDocuments:(NSString *)filename {
    return [[self documentDir] stringByAppendingPathComponent:filename];
}
+ (NSString *)fileWithDocuments:(NSString *)filename AtDir:(NSString *)dir {
    return [[self directoryInDocuments:dir] stringByAppendingPathComponent:filename];
}
+ (NSString *)fileWithCaches:(NSString *)filename {
    return [[self cacheDir] stringByAppendingPathComponent:filename];
}
+ (NSString *)fileWithCaches:(NSString *)filename AtDir:(NSString *)dir {
    return [[self directoryInCaches:dir] stringByAppendingPathComponent:filename];
}

@end
