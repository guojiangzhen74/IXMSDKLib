//
//  IXM.h
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/11.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IXM : NSObject
//NSInteger  type 0 为模态视图  type 1为 nav

/**
 模态登录
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMLoginViewControllerForController:(UIViewController *)viewController
                                        success:(void (^)(id))success
                                        failure:(void (^)(id))failure;

/**
 弹出注册
 @param viewController 调用的控制器
 @param isLogin 是否自动登录
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMRegisterViewControllerForController:(UIViewController *)viewController
                                           isLogin:(BOOL)isLogin
                                           success:(void (^)(id))success
                                           failure:(void (^)(id))failure;
/**
 忘记密码
 
 @param viewController 调用的控制器
 @param isLogin 是否自动登录
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMFindPassWordViewControllerForController:(UIViewController *)viewController
                                               isLogin:(BOOL)isLogin
                                               success:(void (^)(id))success
                                               failure:(void (^)(id))failure;

/**
 修改密码 (必须登录后获取到用户名调用)
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditPassWordViewControllerForController:(UIViewController *)viewController
                                               success:(void (^)(id))success
                                               failure:(void (^)(id))failure;

/**
 用户信息页面 (必须登录后获取到用户名调用)
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMUserInfoViewControllerForController:(UIViewController *)viewController
                                           success:(void (^)(id))success
                                           failure:(void (^)(id))failure;

/**
 获取用户信息
 
 @param success 成功
 @param failure 失败
 */
+(void)GetIXMUserInfoCompletionsuccess:(void (^)(id))success
                               failure:(void (^)(id))failure;

/**
 刷新ssoToken服务（延长token有效期）
 @param success 成功
 @param failure 失败
 */
+(void)RefreshIXMCompletionsuccess:(void (^)(id))success
                           failure:(void (^)(id))failure;

/**
 弹出实名认证
 
 @param viewController 控制器
 @param block 回调
 */
+ (void)ShowIXMRealNameCheckViewControllerForController:(UIViewController *)viewController completion:(void (^)(id))block;
/**
 修改手机号码 (必须登录后获取到用户名调用)
 
 @param viewController  调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditPhoneViewControllerForController:(UIViewController *)viewController
                                            success:(void (^)(id))success
                                            failure:(void (^)(id))failure;

/**
 修改Email (必须登录后获取到用户名,手机号码)
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditEmailViewControllerForController:(UIViewController *)viewController
                                            success:(void (^)(id))success
                                            failure:(void (^)(id))failure;
/**
 实人认证
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMRealPersonAuthenticationViewControllerForController:(UIViewController *)viewController
                                                           success:(void (^)(id))success
                                                           failure:(void (^)(id))failure;
/**
 密保
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMSDKSecurityViewControllerForController:(UIViewController *)viewController
                                              success:(void (^)(id))success
                                              failure:(void (^)(id))failure;
/**
 扫一扫登录
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowQRCodeViewControllerForController:(UIViewController *)viewController
                                      success:(void (^)(id))success
                                      failure:(void (^)(id))failure;
+(void)logOutIXMAccount;
@end
