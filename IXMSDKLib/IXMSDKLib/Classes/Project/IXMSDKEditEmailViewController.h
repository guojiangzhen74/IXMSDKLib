//
//  IXMEditEmailViewController.h
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBackBlock)(id callBack);

@interface IXMSDKEditEmailViewController : UIViewController

@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav

@property(nonatomic,strong) CallBackBlock callbackblock;

@property(nonatomic,copy) NSString *userName;

@property(nonatomic,copy) NSString *userPhone;

-(void)completion:(CallBackBlock)block;

@end
