//
//  IXMToolManager.h
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/26.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IXMSDKToolManager : NSObject
+ (instancetype)shareSession;
-(BOOL)isTelephone:(NSString *)mobile;
-(NSString *)md5:(NSString *)str;
@end
