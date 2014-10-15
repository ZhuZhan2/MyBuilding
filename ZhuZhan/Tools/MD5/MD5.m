//
//  MD5.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-10-13.
//
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return [ret substringWithRange:NSMakeRange(8,16)];
}
@end
