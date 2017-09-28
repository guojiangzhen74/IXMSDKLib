//
//  IXMAccountManager.h
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/10.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IXMSDKAccountManager : NSObject
@property (nonatomic, strong) NSString *sdToken;
@property (nonatomic, strong) NSString *coSessionId;
@property (nonatomic, strong) NSString *loginAccountName;
@property (nonatomic, strong) NSString *certificateName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSDictionary *accountInfo;

@property (nonatomic, assign) BOOL isRealName;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *PWD;
    
    

+ (instancetype)shareSession;
-(void)saveUserLoginStatuesWithAccountInfo:(NSDictionary *)accountInfo;
-(void)clear;
@end
