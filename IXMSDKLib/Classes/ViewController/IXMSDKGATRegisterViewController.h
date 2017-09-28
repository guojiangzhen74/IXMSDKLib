//
//  IXMGATRegisterViewController.h
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/28.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisAndLoginDelegate <NSObject>

- (void)loginBack:(id)info;
@end

typedef void (^CallBackBlock)(id callBack);

@interface IXMSDKGATRegisterViewController : UIViewController
@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav

@property(nonatomic,strong) CallBackBlock callbackblock;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,assign) BOOL isBack;
@property (assign, nonatomic) id<RegisAndLoginDelegate>delegate;


-(void)completion:(CallBackBlock)block;


@end
