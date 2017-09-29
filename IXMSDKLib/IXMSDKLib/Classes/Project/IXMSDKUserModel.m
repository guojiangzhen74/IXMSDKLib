//
//  IXMUserModel.m
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKUserModel.h"
#import "MJExtension.h"
@implementation IXMSDKUserModel
+(instancetype)IXMUserModelWithDic:(NSDictionary *)dict{
    
    IXMSDKUserModel *model=[self mj_objectWithKeyValues:dict];
    return model;
    
}
@end
