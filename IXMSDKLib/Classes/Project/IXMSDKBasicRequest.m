//
//  Request.m
//  IXM
//
//  Created by 严贵敏 on 15/9/20.
//  Copyright © 2015年 严贵敏. All rights reserved.
//

#import "IXMSDKBasicRequest.h"
#import "IXMConfig.h"

#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)  //无网
@implementation IXMSDKBasicRequest

/**
 get请求

 @param url
 @param params
 @param success
 @param failure
 */
+(void)get:(NSString *)url
    params:(id)params
   success:(void (^)(id))success
   failure:(void (^)(id))failure
{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    mgr.requestSerializer.timeoutInterval=10.0f;
    
    //调用配制文件
    IXMConfig *config=[IXMConfig globalConfig];

    if (config.IXMSDKAUTHKEY == nil || config.IXMSDKXMGOV_API_SourceID == nil) {
        NSLog(@"请配制AUTHKEY或者XMGOV_API_SourceID");
    }
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    NSString *requestKey =[NSString stringWithFormat:@"%@%@%@",config.IXMSDKAUTHKEY,timeString,config.IXMSDKXMGOV_API_SourceID];
    NSString *sign=[[IXMSDKToolManager shareSession] md5:requestKey];

    mgr.requestSerializer=[self RequestHeaderWithsign:sign time:timeString];//设置请求头
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络错误!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        
    }];
}


/**
 POST 请求

 @param url
 @param params
 @param success
 @param failure
 */
+(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(id))failure
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    mgr.requestSerializer.timeoutInterval=10.0f;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    //调用配制文件
    IXMConfig *config=[IXMConfig globalConfig];
    
    if (config.IXMSDKAUTHKEY == nil || config.IXMSDKXMGOV_API_SourceID == nil) {
          NSLog(@"请配制AUTHKEY或者XMGOV_API_SourceID");
    }
    
    NSString *requestKey =[NSString stringWithFormat:@"%@%@%@",config.IXMSDKAUTHKEY,timeString,config.IXMSDKXMGOV_API_SourceID];
    NSString *sign=[[IXMSDKToolManager shareSession] md5:requestKey];
    
    
    mgr.requestSerializer=[self RequestHeaderWithsign:sign time:timeString];//设置请求头
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络错误!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    }];
}



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
    failure:(void (^)(id))failure
{
    //判断网络
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"image/jpeg",@"image/png", @"text/html",@"text/json",@"text/javascript", nil];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    //调用配制文件
    IXMConfig *config=[IXMConfig globalConfig];
    
    if (config.IXMSDKAUTHKEY == nil || config.IXMSDKXMGOV_API_SourceID == nil) {
        NSLog(@"请配制AUTHKEY或者XMGOV_API_SourceID");
    }
    
    NSString *requestKey =[NSString stringWithFormat:@"%@%@%@",config.IXMSDKAUTHKEY,timeString,config.IXMSDKXMGOV_API_SourceID];
    NSString *sign=[[IXMSDKToolManager shareSession] md5:requestKey];
    
    
    mgr.requestSerializer=[self RequestHeaderWithsign:sign time:timeString];//设置请求头
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:file name:@"file" fileName:@"file.png" mimeType:@"image/jpeg/png"];
        [formData appendPartWithFileData:backFile name:@"backFile" fileName:@"backFile.png" mimeType:@"image/jpeg/png"];
        [formData appendPartWithFileData:handleFile name:@"handleFile" fileName:@"handleFile.png" mimeType:@"image/jpeg/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(@"网络错误!");
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    }];
}



/**
 请求头设置

 @param sign sign
 @param time time
 @return AFHTTPRequestSerializer
 */
+(AFHTTPRequestSerializer *)RequestHeaderWithsign:(NSString *)sign time:(NSString *)time
{
    //调用配制文件
    IXMConfig *config=[IXMConfig globalConfig];
    AFHTTPRequestSerializer *RequestSerializer=[AFHTTPRequestSerializer serializer];
    [RequestSerializer setValue:sign                             forHTTPHeaderField:@"API-AuthKeY"];
    [RequestSerializer setValue:config.IXMSDKXMGOV_API_SourceID        forHTTPHeaderField:@"API_SourceID"];
    [RequestSerializer setValue:time                             forHTTPHeaderField:@"API_AuthTime"];
    
    return RequestSerializer;
}

//转换成二进制
+(NSData *)Image_TransForm_Data:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image , 0.5);
    //几乎是按0.5图片大小就降到原来的一半 比如这里 24KB 降到11KB
    return imageData;
}


@end



