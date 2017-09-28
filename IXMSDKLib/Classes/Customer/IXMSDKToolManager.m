//
//  IXMToolManager.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/26.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKToolManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation IXMSDKToolManager
+ (instancetype)shareSession {
    static IXMSDKToolManager *session;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        session = [[self alloc] init];
    });
    return session;
}
-(BOOL)isTelephone:(NSString *)mobile{
    if (self == nil)
        return NO;
    
    //联通号码
    NSString *regex_Unicom = @"^(130|131|132|133|185|186|156|155)[0-9]{8}";
    //移动号码
    NSString *regex_CMCC = @"^(134|135|136|137|138|139|147|150|151|152|157|158|159|182|170|183|187|188)[0-9]{8}";
    //电信号码段(电信新增号段181)
    NSString *regex_Telecom = @"^(133|153|180|181|189)[0-9]{8}";
    NSPredicate *pred_Unicom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex_Unicom];
    BOOL isMatch_Unicom = [pred_Unicom evaluateWithObject:mobile];
    NSPredicate *pred_CMCC = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex_CMCC];
    BOOL isMatch_CMCC = [pred_CMCC evaluateWithObject:mobile];
    NSPredicate *pred_Telecom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex_Telecom];
    BOOL isMatch_Telecom = [pred_Telecom evaluateWithObject:mobile];
    if (isMatch_Unicom || isMatch_CMCC || isMatch_Telecom){
        return YES;
    }else{
        return NO;
    }
}
-(NSString *)md5:(NSString *)str{
    const char *cString = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cString, (CC_LONG)strlen(cString), digest); // This is the md5 call
    
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x", digest[i]];
    }
    
    return  md5String;
}
@end
