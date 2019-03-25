//
//  NSURL+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2018/09/19.
//  Copyright © 2018 張帥. All rights reserved.
//

#import "NSURL+ZSExtension.h"
#import "NSString+ZSExtension.h"

@implementation NSURL (ZSExtension)

/// 将url里面的参数转换成字典
- (NSDictionary *)queryParams {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    //query是？后面的参数, 如果没有？就取://后面的
    NSString *query = self.query ?: [self.absoluteString componentsSeparatedByString:@"://"].lastObject;
    if ([NSString isEmpty:query]) {
        return tempDic;
    }
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [query componentsSeparatedByString:@"&"];
    for (int i = 0 ; i < subArray.count ; i++) {
        //通过“=”拆分键和值
        NSArray *dicArray = [subArray[i] componentsSeparatedByString:@"="];
        if (dicArray.count < 2) { continue; }
        //给字典加入元素,=前面为key，后面为value
        tempDic[dicArray[0]] = dicArray[1];
    }
    
    return tempDic;
}

@end
