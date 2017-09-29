//
//  IXMsSDKRequest.m
//  IXM
//
//  Created by 严贵敏 on 15/9/20.
//  Copyright © 2015年 严贵敏. All rights reserved.
//

#import "IXMsSDKRequest.h"
#import "IXMSDKBasicRequest.h"
#import "SVProgressHUD.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKUserModel.h"
@implementation IXMsSDKRequest

#pragma mark- 用户接口
/**
 *	获取短信验证码
 */
+(void)GetSmscodeWithModel:(IXMSDKUserParamsModel *)ParamsModel
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure
{
    if (ParamsModel.confirmType== nil) {
        ParamsModel.confirmType =@"999";
    }
    if ([ParamsModel.confirmType isEqualToString:@"0"]) {
        ParamsModel.confirmType= nil;
    }
    NSDictionary *params = ParamsModel.mj_keyValues;
    
    
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/getsms.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            if (ParamsModel.email.length>0) {
                [SVProgressHUD showSuccessWithStatus:@"已发送,请注意查收!"];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"短信已发送,请注意查收!"];
            }
        }else{
            failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}



/**
 验证手帐号唯一性
 */
+(void)CheckNameWithModel:(IXMSDKUserParamsModel *)ParamsModel
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure
{
    NSDictionary *params = ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/check.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            NSDictionary *dict=responseObj[@"result"];
            success(dict[@"result"]);
            
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}

/**
 *	忘记密码获取验证信息
 *
 */
+(void)GetFindpwdSmscodeWithModel:(IXMSDKUserParamsModel *)ParamsModel
                          suncess:(void (^)(id))success
                          failure:(void (^)(id))failure
{
    NSDictionary *params = ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/findpwdsms.json"];
    
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {

        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj[@"result"]);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
/**
 *	注册
 */
+(void)RegisterWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/register.json"];
    NSLog(@"参数参数%@", params);
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            NSString * result =responseObj[@"result"];
            NSLog(@"正确正确%@", result);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            failure(responseObj);
            NSString * result =responseObj[@"result"];
            NSLog(@"错误错误%@", result);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}

/**
 港澳台注册

 @param ParamsModel 参数
 @param file 照片
 @param backFile 照片
 @param handleFile 照片
 @param success 成功
 @param failure 失败
 */
+(void)GATRegisterWithModel:(IXMSDKUserParamsModel *)ParamsModel
                       file:(NSData *)file
                   backFile:(NSData *)backFile
                 handleFile:(NSData *)handleFile
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/registerHmt.json"];
    
    
    [IXMSDKBasicRequest post:URL params:params file:file backFile:backFile handleFile:handleFile success:^(id responseObj) {
        
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    } failure:^(id error) {
        
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];

        
    }];
}

/**
 *	登录
 *
 *	@param ParamsModel 参数
 *	@param success  成功
 */
+(void)LoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
              suncess:(void (^)(id))success
              failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    
    
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/login.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
        }else{
             failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
    
}
+(void)NoshowSVPLoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
              suncess:(void (^)(id))success
              failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    
    
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/login.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
    
}
/**
 *	登录
 *
 */
+(void)fastLoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
              suncess:(void (^)(id))success
              failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/fastLogin.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        }else{
             failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
    
}

/**
 *	忘记密码重置密码
 */
+(void)FindpasswordWithModel:(IXMSDKUserParamsModel *)ParamsModel
                     suncess:(void (^)(id))success
                     failure:(void (^)(id))failure
{
    

    
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/findpassword.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
             failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
    
}
/**
 *	获取登录的信息
 */
+(void)GetUserInfoWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/getlogin.json"];
    
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
        }else{
            failure(responseObj);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
/**
 *	 修改密码
 */
+(void)EditPasswordWithModel:(IXMSDKUserParamsModel *)ParamsModel
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/repassword.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
            success(responseObj);
        }else{
            
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
            failure(responseObj);
        }
        
        
        
    }failure:^(id error) {
        
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}

/**
 *	 修改手机号码 邮箱
*/
+(void)EditPhoneOrEmailWithModel:(IXMSDKUserParamsModel *)ParamsModel
                     suncess:(void (^)(id))success
                     failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/userManageService.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
             success(responseObj);
        }else{
            
           [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
            failure(responseObj);
        }
        
        
    }failure:^(id error) {
        
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}


/**
 *	刷新ssoToken服务
 */
+(void)SsoTokenWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure
{
 
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/refresh.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(responseObj);
//            [SVProgressHUD showSuccessWithStatus:@"刷新Token成功"];
        }else{
            failure(responseObj);
//            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
/**
 *	退出
 */
+(void)LogoutWithModel:(IXMSDKUserParamsModel *)ParamsModel
               suncess:(void (^)(id))success
               failure:(void (^)(id))failure
{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/logout.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        
        if ([responseObj[@"code"]isEqual:@1001]) {
            success(@"退出成功!");
            [SVProgressHUD showSuccessWithStatus:@"退出成功!"];
        }else{
        
            [SVProgressHUD showErrorWithStatus:@"退出失败!"];
        }
        
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
#pragma mark- 二维码

/**
 *	更新通过Qrcode登录的用户信息（安卓、iOS调用）
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)updateQrcodeModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure{
    
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/login.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"] isEqual:@1001]) {
            success(responseObj[@"result"]);
        }else{
            failure(responseObj[@"result"]);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}

/**
 *	 港澳侨台外用户注册审核被拒后实名信息修改服务
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)editUserInfoModel:(IXMSDKUserParamsModel *)ParamsModel
                    file:(NSData *)file
                backFile:(NSData *)backFile
              handleFile:(NSData *)handleFile
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/modifyHmt.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"] isEqual:@1001]) {
            success(responseObj[@"result"]);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            failure(responseObj[@"result"]);
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
/**
  *	 初级认证
  *	@param ParamsModel 参数
  *	@param success 成功
  */
+(void)RealBasickNameModel:(IXMSDKUserParamsModel *)ParamsModel
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure{
    NSDictionary *params=ParamsModel.mj_keyValues;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/updatePrimaryRealName.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"] isEqual:@1001]) {
            success(responseObj[@"result"]);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
/**
 *	 修改用户密保
 *	@param success 成功
 */
+(void)changeUserPWDLockModel:(NSString *)userName
                    questions:(NSArray *)ques
                      answers:(NSArray *)answer
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure{
    NSDictionary *params=@{@"userName":userName,@"q1":ques[0],@"q2":ques[1],@"q3":ques[2],@"a1":answer[0],@"a2":answer[1],@"a3":answer[2],};;
    NSString *URL=[IXMSDKUrl stringByAppendingString:@"User/updateQuestion.json"];
    [IXMSDKBasicRequest post:URL params:params success:^(id responseObj) {
        if ([responseObj[@"code"] isEqual:@1001]) {
            success(responseObj[@"result"]);
            [SVProgressHUD showSuccessWithStatus:responseObj[@"result"]];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObj[@"result"]];
        }
    }failure:^(id error) {
        failure(@"网络错误,稍后再试!");
        [SVProgressHUD showErrorWithStatus:@"网络错误,稍后再试!"];
    }];
}
@end
