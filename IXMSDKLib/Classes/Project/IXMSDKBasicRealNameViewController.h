//
//  IXMBasicRealNameViewController.h
//  SDKTEST
//
//  Created by 郭江震 on 2017/6/1.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IXMSDKBasicRealNameViewController : UIViewController
@property(nonatomic,assign) NSInteger type; // type 0 为模态视图  type 1为 nav
@property(nonatomic, strong) NSDictionary * userDic;
@end
