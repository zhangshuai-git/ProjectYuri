//
//  RuntimeHandler.h
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _RuntimeHandler: NSObject

+ (void)handleLoad;

+ (void)handleInitialize;

@end

@interface RuntimeHandler : _RuntimeHandler
@end

NS_ASSUME_NONNULL_END
