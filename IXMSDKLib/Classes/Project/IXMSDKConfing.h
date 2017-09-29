//
//  IXMSDKConfing.h
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#ifndef IXMSDKConfing_h
#define IXMSDKConfing_h

#import "Masonry.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKToolManager.h"

//#define IXMSDKUrl             @"http://www.ixm.gov.cn/appcloud/sdk/"
#define IXMSDKUrl             @"https://www.ixm.gov.cn/appcloud/sdk/"

#define placeimage          [UIImage imageNamed:@"placeimage01"]

#define IXMSDKScreenWith          [UIScreen mainScreen].bounds.size.width
#define IXMSDKScreenHeight        [UIScreen mainScreen].bounds.size.height
#define IXMRGB(R,G,B,Alpha)    [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:Alpha]

#endif /* IXMSDKConfing_h */



