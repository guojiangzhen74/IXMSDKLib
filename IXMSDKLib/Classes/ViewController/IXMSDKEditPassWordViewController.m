//
//  IXMEditPassWordViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/24.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKEditPassWordViewController.h"
#import "IXMSDKConfing.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMConfig.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
static NSString *Identifier=@"Identifier";

@interface IXMSDKEditPassWordViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    IXMSDKUserParamsModel *userParamsModel;
    
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    UIButton  *sendBtn;
    IXMConfig *config;
}

@end

@implementation IXMSDKEditPassWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden =YES;
    
    config=[IXMConfig globalConfig];
    
    placeholderArray=@[@"请输入旧密码",@"请输入新密码(8-30位字符包含数字)和英文字符",@"重复输入密码"];
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
    titleLable.text=@"修改密码";
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
    [cell setPlaceholderString:placeholderArray[indexPath.row]  andIndexPath:indexPath];
    
    NSString *indexstr =arrayDataSouce[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    
    
    cell.ispwd =YES;
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


-(void)completion:(CallBackBlock)block{
    
    self.callbackblock = block;
    
}



//提交
-(void)submit{
    
    [arrayDataSouce enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.password = str;
                }
                
                break;
                
            case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.newpassword = str;
                }
                
                break;
            case 2:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel.repassword = str;
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
    //判断密码是否输入
    if ([userParamsModel.password isEqualToString:@""] || userParamsModel.password == nil ) {
        [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
        return;
    }
    
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
    
    [SVProgressHUD show];
    //提交
    [IXMsSDKRequest EditPasswordWithModel:userParamsModel suncess:^(id suncess) {
        
        
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
