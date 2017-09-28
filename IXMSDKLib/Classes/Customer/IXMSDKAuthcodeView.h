//
//  AuthcodeView.h
//  验证码
//
//  Created by suncco on 16/8/25.
//  Copyright © 2016年 Suncco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IXMSDKAuthcodeView : UIView

@property (strong, nonatomic) NSArray *dataArray;//字符素材数组
@property (strong, nonatomic) UIButton * authCodeBtn;
@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串
- (void)getAuthcodeAuto;
@end
