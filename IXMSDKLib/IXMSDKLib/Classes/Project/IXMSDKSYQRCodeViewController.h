//
//  SYQRCodeViewController.h
//  SYQRCodeDemo
//
//  Created by sunbb on 15-1-9.
//  Copyright (c) 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IXMSDKSYQRCodeViewController : UIViewController

@property (nonatomic, copy) void (^IXMSDKSYQRCodeCancleBlock) (IXMSDKSYQRCodeViewController *);//扫描取消
@property (nonatomic, copy) void (^IXMSDKSYQRCodeSuncessBlock) (IXMSDKSYQRCodeViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^IXMSDKSYQRCodeFailBlock) (IXMSDKSYQRCodeViewController *);//扫描失败
@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav

@end
