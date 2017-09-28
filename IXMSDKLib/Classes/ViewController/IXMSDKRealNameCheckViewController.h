//
//  IXMRealNameCheckViewController.h
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/26.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock)(id callBack);

@interface IXMSDKRealNameCheckViewController : UIViewController
@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav

@property(nonatomic,copy) NSString *token ;

@end

