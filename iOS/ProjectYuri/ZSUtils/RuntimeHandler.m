//
//  RuntimeHandler.m
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

#import "RuntimeHandler.h"

@implementation _RuntimeHandler

+ (void)handleLoad {
    NSLog(@"Please override RuntimeHandler.handleLoad if you want to use");
}

+ (void)handleInitialize {
    NSLog(@"Please override RuntimeHandler.handleInitialize if you want to use");
}

@end

@implementation RuntimeHandler

+ (void)initialize {
    [super initialize];
    [self handleInitialize];
}

+ (void)load {
    [super load];
    [self handleLoad];
}

@end
