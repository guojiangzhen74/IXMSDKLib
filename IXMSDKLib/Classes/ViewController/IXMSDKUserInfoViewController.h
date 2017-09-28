//
//  IXMUserInfoViewController.h
//  SDKTEST
//
//  Created by 郭江震 on 2017/5/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBackBlock)(id callBack);
@interface IXMSDKUserInfoViewController : UIViewController
@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav
@property(nonatomic,strong) CallBackBlock callbackblock;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,strong) NSString * token;
-(void)completion:(CallBackBlock)block;
@end
