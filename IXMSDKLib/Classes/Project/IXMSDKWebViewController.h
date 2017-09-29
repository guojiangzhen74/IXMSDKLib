//
//  IXMWebViewController.h
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IXMSDKWebViewController : UIViewController

@property(nonatomic,assign) NSInteger type;
@property(nonatomic,copy) NSString *webUrl;
@property(nonatomic,copy) NSString *webTitle;
@property(nonatomic,assign) BOOL isRegister;

@end
