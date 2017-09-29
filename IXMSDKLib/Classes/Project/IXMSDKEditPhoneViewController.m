//
//  IXMEditPhoneViewController.m
//  IXMSDK
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKEditPhoneViewController.h"
#import "IXMSDKConfing.h"
#import "IXMConfig.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKFindPassWordViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
static NSString *Identifier=@"Identifier";

@interface IXMSDKEditPhoneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    IXMSDKUserParamsModel *userParamsModel;
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    IXMConfig *config;
    UIButton *sendBtn;
    
}

@end

@implementation IXMSDKEditPhoneViewController

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
    
    
    placeholderArray=@[@"请输入新的手机号",@"请输入密码",@"请输入验证码"];
    arrayDataSouce=[NSMutableArray new];
    [arrayDataSouce addObject:@""];
    [arrayDataSouce addObject:@""];
    [arrayDataSouce addObject:@""];
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
    titleLable.text=@"手机号码修改";
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
    UITableView *pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
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
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textField.tag = indexPath.row;
    
    NSString *indexstr =arrayDataSouce[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    
    [cell setPlaceholderString:placeholderArray[indexPath.row]  andIndexPath:indexPath];
    
    if (indexPath.row ==1) {
        cell.ispwd =YES;
    }
    
    if (indexPath.row ==2) {
        cell.isshowbtn = YES;
        sendBtn = cell.sendbtn;
        [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
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
    if ([arrayDataSouce[0] isEqualToString:@""] || ![[IXMSDKToolManager shareSession] isTelephone:arrayDataSouce[0]]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }else{
        
        userParamsModel.mobile =arrayDataSouce[0];
        userParamsModel.confirmType = @"3";
        userParamsModel.userName= self.userName;
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
    
    [arrayDataSouce enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.mobile = str;
                }
                
                break;
                
            case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.password = str;
                }
                
                break;
            case 2:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.code = str;
                }
                
                break;
                
            default:
                break;
        }
        
    }];
    
    //判断用户名是否输入
    if (self.userName == nil ) {
        return;
    }else{
        
        userParamsModel.username = self.userName;
        
    }
    
    //判断手机是否输入
    if (![[IXMSDKToolManager shareSession] isTelephone:userParamsModel.mobile]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    //判断密码是否输入
    if (userParamsModel.password == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (userParamsModel.code == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    [SVProgressHUD show];

    //提交
    [IXMsSDKRequest EditPhoneOrEmailWithModel:userParamsModel  suncess:^(id suncess) {
        
        
        self.callbackblock(suncess);
        
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
        
    } failure:^(id error) {
        
        
    }];
    
    
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
