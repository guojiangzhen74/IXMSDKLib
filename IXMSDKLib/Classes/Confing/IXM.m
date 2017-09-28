//
//  IXM.m
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/11.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXM.h"
#import "IXMSDKLoginViewController.h"
#import "IXMSDKGATRegisterViewController.h"
#import "IXMSDKFindPassWordViewController.h"
#import "IXMSDKEditPassWordViewController.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKRealNameCheckViewController.h"
#import "IXMSDKEditPhoneViewController.h"
#import "IXMSDKEditEmailViewController.h"
#import "IXMSDKUserInfoViewController.h"
#import "IXMSDKAccountManager.h"
#import "IXMSDKRealPersonAuthentication.h"
#import "IXMSDKSecurityViewController.h"
#import "IXMSDKSYQRCodeViewController.h"
@implementation IXM



/**
 模态登录
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMLoginViewControllerForController:(UIViewController *)viewController
                                        success:(void (^)(id))success
                                        failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }

    IXMSDKLoginViewController *vc=[IXMSDKLoginViewController new];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        
        if (back) {
            if ([back[@"code"]isEqual:@1001]) {
                [[IXMSDKAccountManager shareSession]saveUserLoginStatuesWithAccountInfo:back];
                
                if ([IXMSDKAccountManager shareSession].isRealName) {
                     [[IXMSDKAccountManager shareSession] setIsRealName:NO];
                    IXMSDKRealPersonAuthentication * realPersonAuthentication = [IXMSDKRealPersonAuthentication new];
                    realPersonAuthentication.type=type;
                    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:realPersonAuthentication];
                    if (type==1) {
                        if (viewController.navigationController ==nil) {
                            NSLog(@"缺少navigationController");
                            return;
                        }
                        [viewController.navigationController pushViewController:realPersonAuthentication animated:YES];
                    }else{
                        [viewController presentViewController:nav animated:YES completion:nil];
                    }
                }
            }
            success(back);
        }
        
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
}

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
                                           failure:(void (^)(id))failure{
    NSInteger type = 1;
    
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }

    IXMSDKGATRegisterViewController *vc=[IXMSDKGATRegisterViewController new];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    vc.isLogin = isLogin;
    vc.isBack = YES;
    [vc completion:^(id callBack) {
        if ([callBack[@"code"]isEqual:@1001]) {
            [[IXMSDKAccountManager shareSession]saveUserLoginStatuesWithAccountInfo:callBack];
        }
        success(callBack);
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
}


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
                                               failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    
    
    IXMSDKFindPassWordViewController *vc=[IXMSDKFindPassWordViewController new];
    vc.isLogin = isLogin;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        if (back) {
            if ([back[@"code"]isEqual:@1001]) {
                [[IXMSDKAccountManager shareSession]saveUserLoginStatuesWithAccountInfo:back];
                if ([IXMSDKAccountManager shareSession].isRealName) {
                    [[IXMSDKAccountManager shareSession] setIsRealName:NO];
                    IXMSDKRealPersonAuthentication * realPersonAuthentication = [IXMSDKRealPersonAuthentication new];
                    realPersonAuthentication.type=type;
                    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:realPersonAuthentication];
                    if (type==1) {
                        if (viewController.navigationController ==nil) {
                            failure(@"缺少navigationController");
                            return;
                        }
                        [viewController.navigationController pushViewController:realPersonAuthentication animated:YES];
                    }else{
                        [viewController presentViewController:nav animated:YES completion:nil];
                    }
                }

            }
            success(back);
        }
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
}


/**
  修改密码 (必须登录后获取到用户名调用)
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditPassWordViewControllerForController:(UIViewController *)viewController
                                               success:(void (^)(id))success
                                               failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKEditPassWordViewController *vc=[IXMSDKEditPassWordViewController new];
    vc.userName =[IXMSDKAccountManager shareSession].loginAccountName;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        if (back) {
            success(back);
        }
        
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
}

/**
 用户信息页面 (必须登录后获取到用户名调用)
 @param viewController 调用的控制器
 @param success  成功
 @param failure 失败
 */
+ (void)ShowIXMUserInfoViewControllerForController:(UIViewController *)viewController
                                           success:(void (^)(id))success
                                           failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].sdToken.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKUserInfoViewController *vc=[IXMSDKUserInfoViewController new];
    vc.token =[IXMSDKAccountManager shareSession].sdToken;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        if (back) {
            success(back);
        }
        
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
}


/**
  获取用户信息
 @param success 成功
 @param failure 失败
 */
+(void)GetIXMUserInfoCompletionsuccess:(void (^)(id))success
                               failure:(void (^)(id))failure{
    
    if ([IXMSDKAccountManager shareSession].sdToken.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKUserParamsModel *UserParamsModel=[IXMSDKUserParamsModel new];
    
    UserParamsModel.token = [IXMSDKAccountManager shareSession].sdToken;
    
    [IXMsSDKRequest GetUserInfoWithModel:UserParamsModel suncess:^(id back) {
        success(back);
    } failure:^(id error) {
        failure(error);
    }];
}


/**
 刷新ssoToken服务（延长token有效期）
 @param success 成功
 @param failure 失败
 */
+(void)RefreshIXMCompletionsuccess:(void (^)(id))success
                           failure:(void (^)(id))failure{
    if ([IXMSDKAccountManager shareSession].coSessionId.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKUserParamsModel *UserParamsModel=[IXMSDKUserParamsModel new];
    
    UserParamsModel.coSessionId = [IXMSDKAccountManager shareSession].coSessionId;
    
    [IXMsSDKRequest SsoTokenWithModel:UserParamsModel suncess:^(id suncess) {
        NSString * stoken = suncess[@"result"];
        NSRange startRange = [stoken rangeOfString:@"["];
        NSRange endRange = [stoken rangeOfString:@"]"];
        if (startRange.length>0&&endRange.length>0) {
            NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
            NSString *result = [stoken substringWithRange:range];
            [[IXMSDKAccountManager shareSession] setSdToken:result];
            success(result);
        }
    } failure:^(id error) {
        if ([IXMSDKAccountManager shareSession].UserName.length>0) {
            IXMSDKUserParamsModel *userParamsModel;
            userParamsModel=[IXMSDKUserParamsModel new];
            userParamsModel.userName = [IXMSDKAccountManager shareSession].UserName;
            userParamsModel.password = [IXMSDKAccountManager shareSession].PWD;
            [IXMsSDKRequest LoginWithModel:userParamsModel suncess:^(id suncess) {
                if ([suncess[@"code"]isEqual:@1001]) {
                    [[IXMSDKAccountManager shareSession]saveUserLoginStatuesWithAccountInfo:suncess];
                    success(@"刷新失败，已经重新登录");
                }
            } failure:^(id error) {
                [[IXMSDKAccountManager shareSession]clear];
                failure(@"刷新失败，注销");
            }];
            
        }else{
            [[IXMSDKAccountManager shareSession]clear];
            failure(@"刷新失败，注销");
        }
        failure(error);
        
    }];

}


/**
  弹出实名认证

 @param viewController 控制器
 @param block 回调
 */
+ (void)ShowIXMRealNameCheckViewControllerForController:(UIViewController *)viewController completion:(void (^)(id))block{
    
    NSInteger type = 1;
    if (viewController == nil) {
        block(@"请传入viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].sdToken.length==0) {
        block(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKRealNameCheckViewController *vc=[IXMSDKRealNameCheckViewController new];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    vc.token = [IXMSDKAccountManager shareSession].sdToken;
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            block(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }

}


/**
 修改手机号码 (必须登录后获取到用户名调用)

 @param viewController  调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditPhoneViewControllerForController:(UIViewController *)viewController
                                            success:(void (^)(id))success
                                            failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"请传入viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKEditPhoneViewController *vc=[IXMSDKEditPhoneViewController new];
    vc.userName = [IXMSDKAccountManager shareSession].loginAccountName;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        
        if (back) {
            success(back);
        }
        
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }


}


/**
 修改Email (必须登录后获取到用户名,手机号码)
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMEditEmailViewControllerForController:(UIViewController *)viewController
                                            success:(void (^)(id))success
                                            failure:(void (^)(id))failure{
    NSInteger type = 1;

    if (viewController == nil ) {
        failure(@"缺少viewController 或userName ");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    IXMSDKEditEmailViewController *vc=[IXMSDKEditEmailViewController new];
    vc.userName = [IXMSDKAccountManager shareSession].loginAccountName;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [vc completion:^(id back) {
        
        if (back) {
            success(back);
        }
    }];
    vc.type=type;
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
    


}

/**
 实人认证
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMRealPersonAuthenticationViewControllerForController:(UIViewController *)viewController
                                                           success:(void (^)(id))success
                                                           failure:(void (^)(id))failure{
    NSInteger type = 1;
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    IXMSDKRealPersonAuthentication * realPersonAuthentication = [IXMSDKRealPersonAuthentication new];
    realPersonAuthentication.type=type;
     UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:realPersonAuthentication];
    if (type==1) {
        if (viewController.navigationController ==nil) {
            NSLog(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:realPersonAuthentication animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }

}

/**
 密保
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowIXMSDKSecurityViewControllerForController:(UIViewController *)viewController
                                              success:(void (^)(id))success
                                              failure:(void (^)(id))failure{
    NSInteger type = 1;

    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    IXMSDKSecurityViewController * realPersonAuthentication = [IXMSDKSecurityViewController new];
    realPersonAuthentication.type=type;
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:realPersonAuthentication];
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:realPersonAuthentication animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
    
}

/**
 扫一扫登录
 
 @param viewController 调用的控制器
 @param success 成功
 @param failure 失败
 */
+ (void)ShowQRCodeViewControllerForController:(UIViewController *)viewController
                                              success:(void (^)(id))success
                                              failure:(void (^)(id))failure{
    NSInteger type = 1;
    
    if (viewController == nil) {
        failure(@"缺少viewController");
        return;
    }
    if ([IXMSDKAccountManager shareSession].loginAccountName.length==0) {
        failure(@"您还没有登录i厦门");
        return;
    }
    
    //扫描二维码
    IXMSDKSYQRCodeViewController *qrcodevc = [[IXMSDKSYQRCodeViewController alloc] init];
    qrcodevc.type=type;

    qrcodevc.IXMSDKSYQRCodeSuncessBlock = ^(IXMSDKSYQRCodeViewController *aqrvc,NSString *qrString){
        
        if ([qrString containsString:@"QRCODELOGIN"]) {
          
            NSArray *stringArray = [qrString componentsSeparatedByString:@":"];
            //二维码登录
            //二维码登录
            [SVProgressHUD show];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                IXMSDKUserParamsModel *qrcodeParams=[IXMSDKUserParamsModel new];
                NSDictionary * accountInfo= [IXMSDKAccountManager shareSession].accountInfo;
                qrcodeParams.uuid=accountInfo[@"result"][@"user"][@"uuid"];
                qrcodeParams.ssoSessionId=[IXMSDKAccountManager shareSession].sdToken;
                qrcodeParams.trustedSSOSessionIds = stringArray[1];
                //发送用户信息
                [IXMsSDKRequest updateQrcodeModel:qrcodeParams suncess:^(id suncess) {
                
                    [aqrvc.navigationController popViewControllerAnimated:YES];
                } failure:^(id error) {
                    
                    [aqrvc.navigationController popViewControllerAnimated:YES];
                }];
            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请扫描正确的二维码"];
        }
    };
    qrcodevc.IXMSDKSYQRCodeFailBlock = ^(IXMSDKSYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD showErrorWithStatus:@"请扫描正确的二维码"];
    };
    qrcodevc.IXMSDKSYQRCodeCancleBlock = ^(IXMSDKSYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:YES completion:nil];
        
    };
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:qrcodevc];
    if (type==1) {
        if (viewController.navigationController ==nil) {
            failure(@"缺少navigationController");
            return;
        }
        [viewController.navigationController pushViewController:qrcodevc animated:YES];
    }else{
        [viewController presentViewController:nav animated:YES completion:nil];
    }
    
}



+(void)logOutIXMAccount{
    [[IXMSDKAccountManager shareSession]clear];
}
@end
