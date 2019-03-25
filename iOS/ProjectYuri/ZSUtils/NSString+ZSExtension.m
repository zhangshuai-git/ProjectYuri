//
//  NSString+ZSExtension.m
//  ZSUtils
//
//  Created by 張帥 on 2015/5/22.
//  Copyright (c) 2015年 張帥. All rights reserved.
//

#import "NSString+ZSExtension.h"
#import "ZSUtils.h"
#import <CommonCrypto/CommonDigest.h>

/**
 *  拼接url参数
 */
#define URL_ARRAY_PARAM(string, value) (string.length?[string stringByAppendingFormat:@",%@",value]:value)

@implementation NSString (ZSExtension)

+ (BOOL)isEmpty:(NSString *)str {
    return !str || ([str length] == 0) || [str isEqual:[NSNull null]] || [str isEqualToString:@""];
}

- (NSString *)localized {
    return NSLocalizedString(self, nil);
}

- (NSString *)toMD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)urlencodedString {
    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                     (CFStringRef)self,
                                                                                                     (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                     NULL,
                                                                                                     kCFStringEncodingUTF8));
    return encodedString;
}

/// 汉字转拼音
- (NSString *)chineseToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

/// 汉字转拼音首字母
- (NSString *)chineseToPinyinHead {
    NSMutableString *mutableString = [NSMutableString stringWithString:[self chineseToPinyin]];
    NSString *stringPinYinHead = [NSMutableString string];
    NSArray *arrayPinYin = [mutableString componentsSeparatedByString:@" "];
    for (NSString *pinYin in arrayPinYin) {
        stringPinYinHead = [stringPinYinHead stringByAppendingString:[pinYin substringToIndex:1]];
    }
    return stringPinYinHead;
}

///字符串中是否包含中文
- (BOOL)isIncludeChinese {
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

- (BOOL)isPicture {
    NSString *regex = @"gif|jpg|jpeg|bmp|png";
    return [[[self pathExtension] lowercaseString] isMatches:regex];
}

- (BOOL)isAudio {
    NSString *regex = @"mp3|wav|wma|ogg|ape|acc";
    return [[[self pathExtension] lowercaseString] isMatches:regex];
}

- (BOOL)isVideo {
    NSString *regex = @"swf|flv|mp4|rmvb|avi|mpeg|ra|ram|mov|wmv";
    return [[[self pathExtension] lowercaseString] isMatches:regex];
}

///判断字符串是否相等, 忽略大小写
- (BOOL)isCaseInsensitiveEqualToString:(NSString *)string {
    return [self caseInsensitiveCompare:string] == 0;
}

///string是否匹配正则regex
- (BOOL)isMatches:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

+ (BOOL)matche:(NSString *)format string:(NSString *)string {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [emailTest evaluateWithObject:string];
}

/// 0~9 a~z A~Z _ -    一般用于用户名, 或密码
- (BOOL)checkUserName {
    NSString *format = @"^([a-zA-Z0-9]|[_]|[-])+$";
    return [self.class matche:format string:self];
}

- (BOOL)isNewVersion:(NSString *)version {
    NSArray *arr1 = [self componentsSeparatedByString:@"."];
    NSArray *arr2 = [version componentsSeparatedByString:@"."];
    
    BOOL isNew = NO;
    for (NSInteger i = 0; i < arr1.count; i++) {
        if (i < arr2.count) {
            if ([arr1[i] intValue] < [arr2[i] intValue]) {
                isNew = YES;
                break;
            }
        }
    }
    
    if (!isNew && arr1.count < arr2.count) {
        for (NSInteger i = arr1.count; i < arr2.count; i++) {
            if ([arr2[i] intValue] > 0) {
                isNew = YES;
                break;
            }
        }
    }
    
    return isNew;
}

- (BOOL)isValidateEmail {
    NSString *format = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self.class matche:format string:self];
}

- (BOOL)isMobileNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    return  [self.class matche:MOBILE string:self] ||
    [self.class matche:CM string:self] ||
    [self.class matche:CU string:self] ||
    [self.class matche:CT string:self];
}

- (BOOL)isAlphabetOrNumber {
    NSString *format = @"^[A-Za-z0-9]+$";
    return [self.class matche:format string:self];
}

- (BOOL)isChinese {
    NSString *format = @"^[\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

- (BOOL)isNumber {
    NSString *format = @"^[0-9]+$";
    return [self.class matche:format string:self];
}

- (BOOL)isChinCharOrNum {
    NSString *format = @"^[A-Za-z0-9\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

- (BOOL)isChineseOrChar {
    NSString *format = @"^[A-Za-z\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

- (BOOL)isIpAddress {
    NSString *format = @"^(([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+))$";
    return [self.class matche:format string:self];
}

- (BOOL)isSameSubNetworkWithIP:(NSString *)ip {
    if ([self isIpAddress] && [ip isIpAddress]) {
        NSArray *array = [self componentsSeparatedByString:@"."];
        NSArray *ipArray = [ip componentsSeparatedByString:@"."];
        int i = 0;
        for (NSString *s in array) {
            if (![s isEqualToString:[ipArray objectAtIndex:i]]) {
                break;
            }
            i++;
        }
        if (i == 3) {
            return YES;
        }
    }
    return NO;
}

/*字符串中是否包涵Emoji表情*/
- (BOOL)isHaveEmojiString {
    __block BOOL returnValue = NO;
    NSString *string = self;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/* 一百以内整数转中文字符串 */
+ (NSString *)intToChineseString:(int)number {
    NSArray *item = @[@"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十"];
    if (number >= 20) {
        NSString *str = item[(int)number/(int)10];
        str = [str stringByAppendingString:@"十"];
        int d = (int)number%(int)10;
        if (d) {
            str = [str stringByAppendingString:StringFromInt(d)];
        }
        return str;
    } else if (number < 20 && number > 10) {
        NSString *str = @"十";
        int d = (int)number%(int)10;
        if (d) {
            str = [str stringByAppendingString:item[d]];
        }
        return str;
    } else {
        return item[number];
    }
}


+ (NSString *)urlArrayParam:(NSArray *)items {
    NSString *string = nil;
    for (NSString *str in items) {
        string = URL_ARRAY_PARAM( string, str );
    }
    return string;
}

/// 秒数转描述性时间, ex. 3天5小时3分钟
+ (NSString *)secondsToDateString:(NSInteger)time {
    int t = (int)time;
    int d = t / 3600 / 24;
    int h = t % (3600 * 24) / 3600;
    int m = t % 3600 / 60;
    if (d > 0 && h > 0) {
        return [self.class stringWithFormat:@"%d天%d小时%d分钟", d, h, m];
    } else if (h > 0) {
        return [self.class stringWithFormat:@"%d小时%d分钟", h, m];
    } else {
        return [self.class stringWithFormat:@"%d分钟", m];
    }
}

@end

