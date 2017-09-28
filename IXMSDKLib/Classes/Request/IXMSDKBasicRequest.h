//
//  Request.h
//  IXM
//
//  Created by 严贵敏 on 15/9/20.
//  Copyright © 2015年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "IXMSDKConfing.h"
@interface IXMSDKBasicRequest : NSObject

/**
 get请求
 
 @param url  地址
 @param params 参数
 @param success 成功返回
 @param failure 失败返回
 */
+(void)get:(NSString *)url
    params:(id)params
   success:(void (^)(id))success
   failure:(void (^)(id))failure;

/**
 POST 请求
 
 @param url 地址
 @param params 参数
 @param success 成功返回
 @param failure 失败返回
 */
+(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(id))failure;

/**
 上传图片
 
 @param url  地址
 @param params 参数
 @param file 用户证件正面照
 @param backFile 用户证件反面照
 @param handleFile 用户持证照
 @param success 成功返回
 @param failure 失败返回
 */
+(void)post:(NSString *)url
     params:(NSDictionary *)params
       file:(NSData *)file
   backFile:(NSData *)backFile
 handleFile:(NSData *)handleFile
    success:(void(^)(id responseObj))success
    failure:(void (^)(id))failure;

@end
