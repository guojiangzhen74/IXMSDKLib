//
//  IXMSDKUserParamsModel.h
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IXMSDKUserParamsModel : NSObject

@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *newpassword;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *repassword;
@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *ssoSessionId;
@property(nonatomic,copy) NSString *trustedSSOSessionIds;
@property(nonatomic,copy) NSString *email;
@property(nonatomic,copy) NSString *gSessionId;
@property(nonatomic,copy) NSString *coSessionId;
@property(nonatomic,copy) NSString *sessionid;
@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *deviceid;
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *trueName;
@property(nonatomic,copy) NSString *creditID;
@property(nonatomic,copy) NSString *gender;
//港澳台
@property(nonatomic,copy) NSString *certificateType;
@property(nonatomic,copy) NSString *certificateName;
@property(nonatomic,copy) NSString *certificateNum;
@property(nonatomic,copy) NSString *verifyCode;
@property(nonatomic,copy) NSString *confirmType;
@end
