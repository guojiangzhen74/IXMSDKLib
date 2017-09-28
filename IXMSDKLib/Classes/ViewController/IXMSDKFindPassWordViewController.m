//
//  IXMFindPassWordViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/24.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKFindPassWordViewController.h"
#import "IXMSDKConfing.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMConfig.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "IXMSDKAuthcodeView.h"
static NSString *Identifier=@"Identifier";

@interface IXMSDKFindPassWordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    IXMSDKUserParamsModel *userParamsModel;
    UITableView *pageView;
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    UIButton  *sendBtn;
     IXMConfig *config;
    UITextField * selectedField;
    
    
}
@property(nonatomic,strong) IXMSDKAuthcodeView *codeView;
@end

@implementation IXMSDKFindPassWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden =YES;

    
    config=[IXMConfig globalConfig];
    
    placeholderArray=@[@"请输入用户名",@"请输入动态验证码",@"请输入手机验证码",@"请输入新密码(8-30位字符包含数字)和英文字符",@"重复输入新密码"];
    arrayDataSouce=[NSMutableArray new];
    
    for (int i =0; i<placeholderArray.count; i++) {
        [arrayDataSouce addObject:@""];
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
    titleLable.text=@"忘记密码";
    titleLable.textColor =[UIColor whiteColor];
    titleLable.font =[UIFont boldSystemFontOfSize:16];
    [barView addSubview:titleLable];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(barView);
        make.bottom.equalTo(barView).offset(-10);
        
    }];
    
    NSBundle * bundle = [PodAsset bundleForPod:@"IXMSDKLib"];
    UIImage * img = [UIImage imageNamed:@"back_btn@3x"  inBundle: bundle compatibleWithTraitCollection:nil ];
    
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:img forState:UIControlStateNormal];
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
    
    return arrayDataSouce.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.tag = indexPath.row;
    [cell setPlaceholderString:placeholderArray[indexPath.row]  andIndexPath:indexPath];
    
    NSString *indexstr =arrayDataSouce[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    
    
    if (indexPath.row ==1) {
        _codeView = [[IXMSDKAuthcodeView alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
        [cell.contentView addSubview:_codeView];
        
        [cell.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(15);
        }];
        [cell.sendbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.textField.mas_right).offset(-15);
            make.right.equalTo(cell.contentView).offset(-10);
            make.width.mas_equalTo(1);
        }];
        [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.sendbtn.mas_left).offset(-10);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(30);
        }];

    }
    if (indexPath.row ==2) {
        cell.isshowbtn =YES;
        sendBtn = cell.sendbtn;
        [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.row ==3 || indexPath.row ==4) {
        cell.ispwd =YES;
    }
    cell.textField.delegate = self;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    selectedField = textField;
}

- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    
    
    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    
    [arrayDataSouce replaceObjectAtIndex:indexPath withObject:textField.text];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)hiddenKeyBord{
    
    [self.view endEditing:YES];
}




-(void)setTableViewFootView:(UITableView *)tableView{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 200)];
    
    //提交
    UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sumitbtn setBackgroundColor:config.IXMSDKnavBackgroundColor];
    [sumitbtn setTitle:@"确定" forState:UIControlStateNormal];
    sumitbtn.layer.cornerRadius = 4;
    sumitbtn.layer.masksToBounds =YES;
    sumitbtn.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3,10);
    [footView addSubview:sumitbtn];
    
    [sumitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [sumitbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(IXMSDKScreenWith-20);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(footView);
        make.top.equalTo(footView).offset(10);
        
    }];
    
    
    
    tableView.tableFooterView =footView;
    
}
//发送验证码
-(void)sendAction{
    [SVProgressHUD show];
    if( [arrayDataSouce[0]  isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }
    if ([arrayDataSouce[1] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入动态验证码"];
        return;
    }
    if (![arrayDataSouce[1] isEqualToString:_codeView.authCodeStr]) {
        [SVProgressHUD showErrorWithStatus:@"动态码输入错误"];
        return;
    }
    
    userParamsModel.userName = arrayDataSouce[0];
    userParamsModel.mobile =@"12345678912";
    userParamsModel.confirmType = @"999";

    [IXMsSDKRequest GetSmscodeWithModel:userParamsModel suncess:^(id suncess) {
        [self startTime];
    } failure:^(NSError* error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
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

-(void)completion:(CallBackBlock)block{
    
    self.callbackblock = block;
    
}



//登录提交
-(void)submit{
    [arrayDataSouce enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.userName = str;
                }
                
                break;
                
            case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.mobile = @"12345678912";
                }
                
                break;
                
            case 2:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.code = str;
                }
                
                break;
                
            case 3:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.newpassword = str;
                }
                
                break;
                
            case 4:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.repassword = str;
                }
                
                break;
                
            default:
                break;
        }
        
    }];
    
    //姓名
    if (userParamsModel.userName.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }

    //验证码
    if ([userParamsModel.code isEqualToString:@""] || userParamsModel.code ==nil ) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    //密码
    if ([userParamsModel.newpassword isEqualToString:@""] || userParamsModel.newpassword == nil ) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    
    if ([userParamsModel.repassword isEqualToString:@""] || userParamsModel.repassword == nil ) {
        [SVProgressHUD showErrorWithStatus:@"请重复输入新密码"];
        return;
    }
    
    if (![userParamsModel.newpassword isEqualToString:userParamsModel.repassword] ) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一至,请重新输入"];
        return;
    }
    //提交
    [IXMsSDKRequest FindpasswordWithModel:userParamsModel suncess:^(id suncess) {
        if (self.isLogin) {
    
            IXMSDKUserParamsModel *loginParamsMode=[IXMSDKUserParamsModel new];
            loginParamsMode.userName = userParamsModel.userName;
            loginParamsMode.password = userParamsModel.newpassword;
            //登录
            [IXMsSDKRequest NoshowSVPLoginWithModel:loginParamsMode suncess:^(id LoginSuncess) {
                
                self.callbackblock(LoginSuncess);
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
                
            } failure:^(id error) {
                self.callbackblock(error);
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

            }];

        }else{
//          self.callbackblock(suncess);
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
        
    } failure:^(NSError * error) {
//        [SVProgressHUD showErrorWithStatus:error.localizedDescription];

    }];
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
#pragma mark- 键盘事件
-(void)KeyboardWillShow:(NSNotification *)notification{
    CGSize keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    pageView.frame=CGRectMake(0, 64, IXMSDKScreenWith, IXMSDKScreenHeight-64-keyboard.height);
    
}
-(void)KeyboardWillHide:(NSNotification *)notification{
    
    pageView.frame=CGRectMake(0, 64, IXMSDKScreenWith, IXMSDKScreenHeight-64);
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    // textFieldDidChanged 通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
//    使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //    使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}



-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
