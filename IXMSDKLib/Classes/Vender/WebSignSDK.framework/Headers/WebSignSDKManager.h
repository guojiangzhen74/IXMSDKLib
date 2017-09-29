//
//  WebSignSDKManager.h
//  WebSignSDK
//
//  Created by yangyang on 2017/3/6.
//  Copyright © 2017年 ums. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebSignSDKManagerDelegate <NSObject>

-(void)sdkWillDisAppearSign:(BOOL)success
                 contractNo:(NSString *)contractNo
                    urlPath:(NSString *)urlPath;

-(void)sdkDidDisappearSign:(BOOL)success
                contractNo:(NSString *)contractNo
                   urlPath:(NSString *)urlPath;

@end


@interface WebSignSDKManager : NSObject


+(WebSignSDKManager *)shared;

/**
 传入相应信息

 @param realName 第三方应用当前用户的户名
 @param certId 第三方应用当前身份证号
 @param acctNo 第三方应用当前用户的银行卡
 @param phone 第三方用用当前用户电话
 @param isCheckBlackList 是否要验证黑名单
 @param platCode 分配给第三方的接号
 @param templateNo 分配给第三方应用的协议模板编号
 @param delegate 代理
 */
-(void)starSDKWithRealName:(NSString *)realName
                    certId:(NSString *)certId
                    acctNo:(NSString *)acctNo
                     phone:(NSString *)phone
          isCheckBlackList:(BOOL)isCheckBlackList
                  platCode:(NSString *)platCode
                templateNo:(NSString *)templateNo
                  delegate:(id)delegate;

-(void)quit;



@end
