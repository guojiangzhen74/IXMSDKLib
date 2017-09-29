//
//  IXMConfig.h
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IXMConfig : NSObject

+ (IXMConfig*) globalConfig;

@property (nonatomic, copy) NSString *IXMSDKAUTHKEY;
@property (nonatomic, copy) NSString *IXMSDKXMGOV_API_SourceID;
@property (nonatomic, strong) UIColor  *IXMSDKnavBackgroundColor;

@end
