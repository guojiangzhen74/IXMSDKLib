//
//  IXMConfig.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMConfig.h"
#import "IXMSDKConfing.h"
@implementation IXMConfig

+ (IXMConfig *)globalConfig
{
    static IXMConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [IXMConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.IXMSDKnavBackgroundColor =IXMRGB(30, 181, 231,1);
        
    }
    
    return self;
}

@end
