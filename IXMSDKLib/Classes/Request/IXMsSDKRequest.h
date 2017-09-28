//
//  IXMsSDKRequest.h
//  IXM
//
//  Created by 严贵敏 on 15/9/20.
//  Copyright © 2015年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IXMSDKConfing.h"
//参数
@class  IXMSDKUserParamsModel;
@class  IXMApplistsParamsModel;
@class  IXMServiceCategoryNextParamsModel;
@class  IXMSearchParamsModel;
@interface IXMsSDKRequest : NSObject

#pragma mark- 用户接口
/**
 *	获取短信验证码
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)GetSmscodeWithModel:(IXMSDKUserParamsModel *)ParamsModel
                   suncess:(void (^)(id))success
                   failure:(void (^)(id))failure;

/**
 *	忘记密码获取验证信息
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)GetFindpwdSmscodeWithModel:(IXMSDKUserParamsModel *)ParamsModel
                          suncess:(void (^)(id))success
                          failure:(void (^)(id))failure;

/**
 *	注册
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)RegisterWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure;


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
                    failure:(void (^)(id))failure;

/**
 *	登录
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)LoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
              suncess:(void (^)(id))success
              failure:(void (^)(id))failure;
+(void)NoshowSVPLoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
                       suncess:(void (^)(id))success
                       failure:(void (^)(id))failure;

/**
 *	登录
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)fastLoginWithModel:(IXMSDKUserParamsModel *)ParamsModel
                  suncess:(void (^)(id))success
                  failure:(void (^)(id))failure;

/**
 *	忘记密码重置密码
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)FindpasswordWithModel:(IXMSDKUserParamsModel *)ParamsModel
                     suncess:(void (^)(id))success
                     failure:(void (^)(id))failure;

/**
 *	 修改密码
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)EditPasswordWithModel:(IXMSDKUserParamsModel *)ParamsModel
                        suncess:(void (^)(id))success
                        failure:(void (^)(id))failure;

/**
 *	 修改手机号码 邮箱
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)EditPhoneOrEmailWithModel:(IXMSDKUserParamsModel *)ParamsModel
                         suncess:(void (^)(id))success
                         failure:(void (^)(id))failure;

/**
 *	获取登录的信息
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)GetUserInfoWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure;

/**
 *	刷新ssoToken服务
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)SsoTokenWithModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure;
/**
 *	退出
 *
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)LogoutWithModel:(IXMSDKUserParamsModel *)ParamsModel
               suncess:(void (^)(id))success
               failure:(void (^)(id))failure;

#pragma mark- 二维码

/**
 *	 更新通过Qrcode登录的用户信息（安卓、iOS调用）
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)updateQrcodeModel:(IXMSDKUserParamsModel *)ParamsModel
                suncess:(void (^)(id))success
                failure:(void (^)(id))failure;

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
                 failure:(void (^)(id))failure;
/**
 *	 初级认证
 *	@param ParamsModel 参数
 *	@param success 成功
 */
+(void)RealBasickNameModel:(IXMSDKUserParamsModel *)ParamsModel
                 suncess:(void (^)(id))success
                 failure:(void (^)(id))failure;
/**
 *	 修改用户密保
 *	@param success 成功
 */
+(void)changeUserPWDLockModel:(NSString *)userName
                    questions:(NSArray *)ques
                      answers:(NSArray *)answer
                      suncess:(void (^)(id))success
                      failure:(void (^)(id))failure;
@end
