//
//  NSFileManager+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2018/09/18.
//  Copyright © 2018 張帥. All rights reserved.
//

#import "NSFileManager+ZSExtension.h"

@implementation NSFileManager (ZSExtension)

+ (NSURL *)zs_URLForDirectory:(NSSearchPathDirectory)directory {
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)zs_pathForDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)zs_documentsURL {
    return [self zs_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)zs_documentsPath {
    return [self zs_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)zs_libraryURL {
    return [self zs_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)zs_libraryPath {
    return [self zs_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)zs_cachesURL {
    return [self zs_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)zs_cachesPath {
    return [self zs_pathForDirectory:NSCachesDirectory];
}


@end
