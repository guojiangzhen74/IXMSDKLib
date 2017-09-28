//
//  IXMAccountManager.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/10.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKAccountManager.h"

@implementation IXMSDKAccountManager

+ (instancetype)shareSession {
    static IXMSDKAccountManager *session;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        session = [[self alloc] init];
    });
    return session;
}
//sdToken
-(NSString *)sdToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_sdToken"];
}
-(void)setSdToken:(NSString *)sdToken{
    [[NSUserDefaults standardUserDefaults] setObject:sdToken forKey:@"IXMSDK_sdToken"];
}

//coSessionId
-(NSString *)coSessionId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_coSessionId"];
}
-(void)setCoSessionId:(NSString *)coSessionId{
    [[NSUserDefaults standardUserDefaults] setObject:coSessionId forKey:@"IXMSDK_coSessionId"];
}
//loginAccountName
-(NSString *)loginAccountName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_loginAccountName"];
}
-(void)setLoginAccountName:(NSString *)loginAccountName{
    [[NSUserDefaults standardUserDefaults] setObject:loginAccountName forKey:@"IXMSDK_loginAccountName"];
}
//mobile
-(NSString *)mobile{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_mobile"];
}
-(void)setMobile:(NSString *)mobile{
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"IXMSDK_mobile"];
}
//certificateName
-(NSString *)certificateName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_certificateName"];
}
-(void)setCertificateName:(NSString *)certificateName{
    [[NSUserDefaults standardUserDefaults] setObject:certificateName forKey:@"IXMSDK_certificateName"];
}
//accountInfo
-(NSDictionary *)accountInfo{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_accountInfo"];
}
//isRealName
-(BOOL)isRealName{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"IXMSDK_isRealName"];
}
-(void)setIsRealName:(BOOL)isRealName{
    [[NSUserDefaults standardUserDefaults] setBool:isRealName forKey:@"IXMSDK_isRealName"];
}


-(NSString*)UserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_UserName"];
}
    
-(void)setUserName:(NSString*)UserName{
    [[NSUserDefaults standardUserDefaults] setObject:UserName forKey:@"IXMSDK_UserName"];
}
-(NSString*)PWD{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IXMSDK_PWD"];
}
-(void)setPWD:(NSString*)PWD{
    [[NSUserDefaults standardUserDefaults] setObject:PWD forKey:@"IXMSDK_PWD"];
}
    
    
-(void)saveUserLoginStatuesWithAccountInfo:(NSDictionary *)accountInfo{
    NSDictionary *result=accountInfo[@"result"];
    NSDictionary *user=result[@"user"];
    
    [[NSUserDefaults standardUserDefaults] setObject:result[@"sdToken"] forKey:@"IXMSDK_sdToken"];
    [[NSUserDefaults standardUserDefaults] setObject:result[@"coSessionId"] forKey:@"IXMSDK_coSessionId"];
    [[NSUserDefaults standardUserDefaults] setObject:user[@"loginAccountName"] forKey:@"IXMSDK_loginAccountName"];
    [[NSUserDefaults standardUserDefaults] setObject:user[@"mobile"] forKey:@"IXMSDK_mobile"];
    [[NSUserDefaults standardUserDefaults] setObject:user[@"certificateName"] forKey:@"IXMSDK_certificateName"];
    
    [[NSUserDefaults standardUserDefaults] setObject:accountInfo forKey:@"IXMSDK_accountInfo"];

}
-(void)clear{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_sdToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_coSessionId"];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_loginAccountName"];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_mobile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_certificateName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IXMSDK_accountInfo"];


}
- (NSString *)stringForKey:(NSString *)key {
    NSString *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return data;
}
@end
