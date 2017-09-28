//
//  ViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/19.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "ViewController.h"
#import "IXM.h"
#import "IXMConfig.h"
#import "SVProgressHUD.h"

static NSString *cellIdentifier=@"cellIdentifier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    UITableView *mainView;
    UIBarButtonItem * rightItem;
    UILabel * contentLabel;
    CGFloat  footHeight;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    mainView=[[UITableView alloc]initWithFrame:CGRectMake(30, 0, self.view.bounds.size.width-60, self.view.bounds.size.height)style:UITableViewStyleGrouped];
    mainView.showsVerticalScrollIndicator = NO;
    mainView.dataSource=self;
    mainView.delegate =self;

    [mainView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:mainView];
    
    footHeight = 0;
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainView.bounds.size.width-20, footHeight)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:16];
    
    rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Push视图" style:UIBarButtonItemStyleDone target:self action:@selector(changeType)];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    
    
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.type = 1;

}
-(void)changeType{
    if (self.type==0) {
        self.type = 1;
        [rightItem setTitle:@"Push视图"];
        
    }else{
        self.type = 0;
        [rightItem setTitle:@"模态视图"];
    }

}
#pragma mark- tab
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 18;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=@"登录";
            break;
        case 1:
            cell.textLabel.text=@"获取用户信息";
            break;
        case 2:
            cell.textLabel.text=@"查看用户信息";
            break;
        case 3:
            cell.textLabel.text=@"查看用户实名认证情况";
            break;
        case 4:
            cell.textLabel.text=@"忘记密码";
            break;
        case 5:
            cell.textLabel.text=@"忘记密码并自动登录";
            break;
        case 6:
            cell.textLabel.text=@"修改用户密码";
            break;
        case 7:
            cell.textLabel.text=@"修改手机号码";
            break;
        case 8:
            cell.textLabel.text=@"修改邮箱";
            break;
        case 9:
            cell.textLabel.text=@"注册";
            break;
        case 10:
            cell.textLabel.text=@"注册并自动登录";
            break;
        case 11:
            cell.textLabel.text=@"刷新TOKEN";
            break;
        
        case 12:
            cell.textLabel.text=@"注销";
            break;
        case 13:
            cell.textLabel.text=@"设置颜色1";
            break;
        case 14:
            cell.textLabel.text=@"设置颜色2";
            break;
        case 15:
            cell.textLabel.text=@"实人认证";
            break;
        case 16:
            cell.textLabel.text=@"密保";
            break;
        case 17:
            cell.textLabel.text=@"扫一扫登录";
            break;
        default:
            break;
    }    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            //登录
            [IXM ShowIXMLoginViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 1:
        {
            //获取用户信息
            [SVProgressHUD show];
            [IXM GetIXMUserInfoCompletionsuccess:^(id success) {
                [SVProgressHUD dismiss];
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [SVProgressHUD dismiss];
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 2:
        {
            //进入用户信息
            [IXM ShowIXMUserInfoViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 3:
        {
            //获取实名认证
            [IXM ShowIXMRealNameCheckViewControllerForController:self completion:^(id callback) {
                [self showInfoActionWithCallback:callback];
            }];
        }
            break;
        case 4:
        {
            //忘记密码
            [IXM ShowIXMFindPassWordViewControllerForController:self isLogin:NO success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 5:
        {
            //忘记密码并自动登录
            [IXM ShowIXMFindPassWordViewControllerForController:self isLogin:YES success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 6:
        {
            //修改密码
            [IXM ShowIXMEditPassWordViewControllerForController:self success:^(id success) {
                 [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 7:
        {
            //修改手机号码
            [IXM ShowIXMEditPhoneViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];

            }];

        }
            break;
        case 8:
        {
            //修改邮箱
            [IXM ShowIXMEditEmailViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 9:
        {
            //注册
            [IXM ShowIXMRegisterViewControllerForController:self isLogin:NO success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 10:
        {
            //注册并自动登录
            [IXM ShowIXMRegisterViewControllerForController:self isLogin:YES success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 11:
        {
            //刷新ssoToken服务（延长token有效期）
            [IXM RefreshIXMCompletionsuccess:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
        }
            break;
        case 12:
            [self showAlertViewWithMessage:@"退出登录" action:@"注销suncco"];
            
            break;
        case 13:
            [[IXMConfig globalConfig] setIXMSDKnavBackgroundColor:[UIColor colorWithRed:243/255.0 green:87/255.0 blue:66/255.0 alpha:1]];
            break;
        case 14:
            [[IXMConfig globalConfig] setIXMSDKnavBackgroundColor:[UIColor colorWithRed:31/255.0 green:138/255.0 blue:254/255.0 alpha:1]];
            break;
        case 15:{
           //认证
            [IXM ShowIXMRealPersonAuthenticationViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
            break;
        }
        case 16:
        {
            //密保
            [IXM ShowIXMSDKSecurityViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
            break;
        }
        case 17:
        {
            //扫一扫
            [IXM ShowQRCodeViewControllerForController:self success:^(id success) {
                [self showInfoActionWithCallback:success];
            } failure:^(id error) {
                [self showInfoActionWithCallback:error];
            }];
            break;
        }
        default:
            break;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)showAlertViewWithMessage:(NSString *)message action:(NSString *)action{
    
    
    if ([message isEqualToString:@"退出登录"]) {
        UIAlertController * msgAlert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请确认是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [IXM logOutIXMAccount];
        }];
        UIAlertAction * calAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [msgAlert addAction:calAction];
        [msgAlert addAction:sureAction];
        [self presentViewController:msgAlert animated:YES completion:nil];
        
    }else{
        UIAlertController * msgAlert = [UIAlertController alertControllerWithTitle:action message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * calAction =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [msgAlert addAction:calAction];
         [self presentViewController:msgAlert animated:YES completion:nil];
    }
   
}
#pragma mark 保存登录状态方法
//-(void)saveUserLoginStatuesWithAccountInfo:(NSDictionary *)accountInfo{
//    NSDictionary *result=accountInfo[@"result"];
//    NSDictionary *user=result[@"user"];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:result[@"sdToken"] forKey:@"sdToken"];
//    [[NSUserDefaults standardUserDefaults] setObject:result[@"coSessionId"] forKey:@"coSessionId"];
//    [[NSUserDefaults standardUserDefaults] setObject:user[@"loginAccountName"] forKey:@"IXMUserName"];
//    [[NSUserDefaults standardUserDefaults] setObject:user[@"mobile"] forKey:@"IXMUserMobile"];
//}
#pragma mark Json 字符串
-(NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString * result = [NSMutableString new];
    [result setString:jsonString];
    NSRange range = NSMakeRange(0, [result length]);
    [result replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:range];
    return result;
}
#pragma 计算字符串高度
- (CGFloat)calStrSize:(NSString *)text andWidth:(CGFloat)w andFontSize:(CGFloat)fontsize {
    CGFloat height = [text boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size.height;
    return height;
}
#pragma  mark 打印信息
-(void)showInfoActionWithCallback:(id)callback{
    CGRect frame = contentLabel.frame;
    if ([callback isKindOfClass:[NSString class]]) {
        footHeight = [self calStrSize:[NSString stringWithFormat:@"%@", callback] andWidth:mainView.bounds.size.width andFontSize:16];
        frame.size.height = footHeight;
        frame.size.width = mainView.bounds.size.width-20;
        contentLabel.frame = frame;
        [contentLabel setText:[NSString stringWithFormat:@"%@", callback]];
    }else{
        footHeight = [self calStrSize:[NSString stringWithFormat:@"%@", [self convertToJSONData:callback]] andWidth:mainView.bounds.size.width andFontSize:16];
        frame.size.height = footHeight;
        frame.size.width = mainView.bounds.size.width-20;
        contentLabel.frame = frame;
        [contentLabel setText:[NSString stringWithFormat:@"%@", [self convertToJSONData:callback]]];
    }
    [mainView setTableFooterView:contentLabel];
}
@end
