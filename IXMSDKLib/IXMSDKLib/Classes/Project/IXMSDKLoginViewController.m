//
//  IXMLoginViewController.m
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKLoginViewController.h"
#import "IXMSDKConfing.h"
#import "IXMConfig.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKFindPassWordViewController.h"
#import "IXMSDKGATRegisterViewController.h"
#import "IXMSDKEditRegisViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "IXMSDKAccountManager.h"
static NSString *Identifier=@"Identifier";

@interface IXMSDKLoginViewController ()<UITableViewDelegate,UITableViewDataSource,RegisAndLoginDelegate>{
    
    IXMSDKUserParamsModel *userParamsModel;
    
    NSArray *titleArray;
    NSArray *placeholderArray1;
    NSMutableArray *arrayDataSouce1;
    NSArray *placeholderArray2;
    NSMutableArray *arrayDataSouce2;
    IXMConfig *config;
    UISwitch *isfast;
    UIButton *sendBtn;
    UITableView *pageView;
    
    UITextField * mobileTextField;
    
}
    
    @end

@implementation IXMSDKLoginViewController
    
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    config=[IXMConfig globalConfig];
    
    
    switch (self.type) {
        case 0:
        self.fd_prefersNavigationBarHidden =YES;
        
        break;
        case 1:
        self.fd_prefersNavigationBarHidden =YES;
        
        break;
        
        default:
        break;
    }
    
    
    placeholderArray1=@[@"请输入用户名/手机号",@"请输入密码"];
    arrayDataSouce1=[NSMutableArray new];
    for (int i =0; i<placeholderArray1.count; i++) {
        if (i==0) {
            if ([IXMSDKAccountManager shareSession].UserName) {
                [arrayDataSouce1 addObject:[IXMSDKAccountManager shareSession].UserName];
            }else{
                [arrayDataSouce1 addObject:@""];
            }
        }else{
            if ([IXMSDKAccountManager shareSession].PWD) {
                [arrayDataSouce1 addObject:@""];

//                [arrayDataSouce1 addObject:[IXMSDKAccountManager shareSession].PWD];
            }else{
                [arrayDataSouce1 addObject:@""];
            }
        }
    }
    
    placeholderArray2=@[@"请输入手机号",@"请输入验证码"];
    arrayDataSouce2=[NSMutableArray new];
    for (int i =0; i<placeholderArray2.count; i++) {
        [arrayDataSouce2 addObject:@""];
    }
    
    
    
    UIView *barView=[UIView new];
    barView.backgroundColor =config.IXMSDKnavBackgroundColor;
    [self.view addSubview:barView];
    
    
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(IXMSDKScreenWith);
        make.height.mas_equalTo(64);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
        
    }];
    
    UILabel *titleLable=[UILabel new];
    titleLable.text=@"登录";
    titleLable.textColor =[UIColor whiteColor];
    titleLable.font =[UIFont boldSystemFontOfSize:16];
    [barView addSubview:titleLable];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(barView);
        make.bottom.equalTo(barView).offset(-10);
        
    }];
    
    
    UIButton *btn=[[UIButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:14];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [barView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(barView).offset(0);
        make.centerY.equalTo(titleLable);
    }];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    pageView= [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    pageView.delegate = self;
    pageView.dataSource = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBord)];
    [pageView addGestureRecognizer:gesture];
    
    
    [self setTableViewFootView:pageView];
    
    [self.view addSubview:pageView];
    
    //参数
    userParamsModel=[IXMSDKUserParamsModel new];
    
    
}
    
-(void)backAction{
    
    switch (self.type) {
        case 0:
        [self dismissViewControllerAnimated:YES completion:^{
            
            
        }];
        break;
        
        case 1:
        [[self navigationController] popViewControllerAnimated:YES];
        break;
        
        
        default:
        break;
    }
}
    
#pragma mark- 表格
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.tag = indexPath.row;
    if (isfast.on) {
        
        [cell setPlaceholderString:placeholderArray2[indexPath.row]  andIndexPath:indexPath];
        
        NSString *indexstr =arrayDataSouce2[indexPath.row];
        if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
            [cell setString:indexstr andIndexPath:indexPath];
        }
        
    }else{
        [cell setPlaceholderString:placeholderArray1[indexPath.row]  andIndexPath:indexPath];
        
        NSString *indexstr =arrayDataSouce1[indexPath.row];
        if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
            [cell setString:indexstr andIndexPath:indexPath];
        }
    }
    
    if (indexPath.row==0) {
        mobileTextField = cell.textField;
    }
    if (indexPath.row ==1) {
        
        cell.ispwd = YES;
        if (isfast.on) {
            cell.ispwd = NO;
            cell.isshowbtn = YES;
            sendBtn = cell.sendbtn;
            [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return cell;
    
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
#pragma mark - private
    
    
- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    if (isfast.on) {
        [arrayDataSouce2 replaceObjectAtIndex:indexPath withObject:textField.text];
    }else{
        [arrayDataSouce1 replaceObjectAtIndex:indexPath withObject:textField.text];
    }
    
}
    
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
    
- (void)hiddenKeyBord{
    
    [self.view endEditing:YES];
}
    
    
-(void)setTableViewFootView:(UITableView *)tableView{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 200)];
    
    
    UILabel *fastLable=[UILabel new];
    fastLable.text =@"快捷登录";
    fastLable.textColor =IXMRGB(100, 100, 100, 1);
    fastLable.font =[UIFont systemFontOfSize:14];
    
    [footView addSubview:fastLable];
    
    [fastLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(footView).offset(15);
        make.left.equalTo(footView).offset(10);
        
    }];
    
    isfast=[UISwitch new];
    isfast.onTintColor =config.IXMSDKnavBackgroundColor;
    [isfast addTarget:self action:@selector(swichAction:) forControlEvents:UIControlEventValueChanged];
    [footView addSubview:isfast];
    
    [isfast mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(fastLable);
        make.right.equalTo(footView).offset(-10);
        
    }];
    
    
    //提交
    UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sumitbtn setBackgroundColor:config.IXMSDKnavBackgroundColor];
    [sumitbtn setTitle:@"登录" forState:UIControlStateNormal];
    sumitbtn.layer.cornerRadius = 4;
    sumitbtn.layer.masksToBounds =YES;
    sumitbtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3,10);
    [footView addSubview:sumitbtn];
    
    [sumitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [sumitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(IXMSDKScreenWith-20);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(footView);
        make.top.equalTo(footView).offset(64);
        
    }];
    
    //忘记密码
    UIButton *findPassWordBtn=[UIButton new];
    [findPassWordBtn setTitleColor:IXMRGB(100, 100, 100, 1) forState:UIControlStateNormal];
    findPassWordBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [findPassWordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [findPassWordBtn addTarget:self action:@selector(pushToFindPassword) forControlEvents:UIControlEventTouchUpInside];
    
    
    [footView addSubview:findPassWordBtn];
    
    [findPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sumitbtn.mas_bottom).offset(10);
        make.left.equalTo(sumitbtn);
    }];
    
    
    //注册
    UIButton *registeredBtn=[UIButton new];
    [registeredBtn setTitleColor:IXMRGB(100, 100, 100, 1) forState:UIControlStateNormal];
    registeredBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [registeredBtn setTitle:@"还没有帐号?去注册" forState:UIControlStateNormal];
    [registeredBtn addTarget:self action:@selector(pushToRegistered) forControlEvents:UIControlEventTouchUpInside];
    
    
    [footView addSubview:registeredBtn];
    
    [registeredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sumitbtn.mas_bottom).offset(10);
        make.right.equalTo(sumitbtn);
    }];
    
    tableView.tableFooterView =footView;
    
}
    
-(void)swichAction:(UISwitch *)isfast{
    [mobileTextField resignFirstResponder];
    [pageView reloadData];
    
}
    
    //发送验证码
-(void)sendAction{
    [SVProgressHUD show];
    if ([arrayDataSouce2[0] isEqualToString:@""] || ![[IXMSDKToolManager shareSession]isTelephone:arrayDataSouce2[0]] ) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }else{
        userParamsModel.mobile =arrayDataSouce2[0];
        userParamsModel.confirmType = @"8";
    }
    [IXMsSDKRequest GetSmscodeWithModel:userParamsModel suncess:^(id suncess) {
        [self startTime];
    } failure:^(id error) {
        
    }];
}
    /**
     *	倒计时
     */
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                sendBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sendBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                sendBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
    
    //登录提交
-(void)submit{
    [SVProgressHUD show];
    if (isfast.on) {
        
        [arrayDataSouce2 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.mobile = str;
                }
                
                break;
                
                case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.verifyCode = str;
                }
                
                break;
                
                default:
                break;
            }
            
        }];
        
        //判断用户名是否输入
        if (userParamsModel.mobile == nil) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return;
        }
        //判断密码是否输入
        if (userParamsModel.verifyCode == nil) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        //提交
        [IXMsSDKRequest fastLoginWithModel:userParamsModel suncess:^(id suncess) {
            
            
            NSDictionary * logDic =[NSDictionary new];
            logDic = [suncess copy];
            self.callbackblock(suncess);
            NSString * signStr =[NSString stringWithFormat:@"%@",logDic[@"result"][@"hmtMsgSign"]];
            if ([signStr isEqualToString:@"1"]) {
                UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:logDic[@"result"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * leftAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if (suncess) {
                        switch (self.type) {
                            case 0:
                            [self dismissViewControllerAnimated:YES completion:nil];
                            break;
                            case 1:
                            [self.navigationController popViewControllerAnimated:YES];
                            break;
                            default:
                            break;
                        }
                    }
                    
                }];
                UIAlertAction * rightAction =[UIAlertAction actionWithTitle:@"马上修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    IXMSDKEditRegisViewController * vc =[IXMSDKEditRegisViewController new];
                    vc.userDic =[suncess copy];
                    vc.type =self.type;
                    if (self.type ==0) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
                        }];
                    }else{
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
                [alertController addAction:leftAction];
                [alertController addAction:rightAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                if (suncess) {
                    switch (self.type) {
                        case 0:
                        [self dismissViewControllerAnimated:YES completion:nil];
                        break;
                        case 1:
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                        default:
                        break;
                    }
                }
            }
            
        } failure:^(id error) {
            
            
        }];
        
        
    }else{
        //普通登录~
        [arrayDataSouce1 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.userName = str;
                }
                
                break;
                
                case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.password = str;
                }
                
                break;
                
                default:
                break;
            }
            
        }];
        
        //判断用户名是否输入
        if (userParamsModel.userName == nil && userParamsModel.mobile == nil) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入用户名/手机号"];
            return;
        }
        //判断密码是否输入
        if (userParamsModel.password == nil) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        //提交
        [IXMsSDKRequest LoginWithModel:userParamsModel suncess:^(id suncess) {
            [[IXMSDKAccountManager shareSession] setUserName:userParamsModel.userName];
            [[IXMSDKAccountManager shareSession] setPWD:userParamsModel.password];
            
            NSDictionary * logDic =[NSDictionary new];
            logDic = [suncess copy];
            self.callbackblock(suncess);
            NSString * signStr =[NSString stringWithFormat:@"%@",logDic[@"result"][@"hmtMsgSign"]];
            if ([signStr isEqualToString:@"1"]) {
                UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:logDic[@"result"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * leftAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if (suncess) {
                        switch (self.type) {
                            case 0:
                            [self dismissViewControllerAnimated:YES completion:nil];
                            break;
                            case 1:
                            [self.navigationController popViewControllerAnimated:YES];
                            break;
                            default:
                            break;
                        }
                    }
                    
                }];
                UIAlertAction * rightAction =[UIAlertAction actionWithTitle:@"马上修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    IXMSDKEditRegisViewController * vc =[IXMSDKEditRegisViewController new];
                    vc.userDic =[suncess copy];
                    vc.type =self.type;
                    if (self.type ==0) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
                        }];
                    }else{
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
                [alertController addAction:leftAction];
                [alertController addAction:rightAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                if (suncess) {
                    [SVProgressHUD dismiss];
                    switch (self.type) {
                        case 0:
                        [self dismissViewControllerAnimated:YES completion:nil];
                        break;
                        case 1:
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                        default:
                        break;
                    }
                }
            }
            
        } failure:^(id error) {
            
            
        }];
        
        
    }
    
    
}
    
    
    //忘记密码
-(void)pushToFindPassword{
    
    IXMSDKFindPassWordViewController *vc=[IXMSDKFindPassWordViewController new];
    vc.type = self.type;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
    
    //注册
-(void)pushToRegistered{
    
    IXMSDKGATRegisterViewController *vc=[IXMSDKGATRegisterViewController new];
    vc.type = self.type;
    vc.isBack = NO;
    vc.delegate = self;
    vc.isLogin = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)loginBack:(id)info{
    self.callbackblock(info);
}
    
-(void)completion:(CallBackBlock)block{
    
    self.callbackblock = block;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
    
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    // textFieldDidChanged 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];}
    
    
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
    
    @end
