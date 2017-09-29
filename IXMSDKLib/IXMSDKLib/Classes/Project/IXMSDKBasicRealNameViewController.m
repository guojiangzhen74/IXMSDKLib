//
//  IXMBasicRealNameViewController.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/6/1.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKBasicRealNameViewController.h"
#import "IXMSDKConfing.h"
#import "IXMConfig.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKSelectCell.h"
#import "IXMSDKPickerView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

static NSString *Identifier=@"Identifier";
static NSString *selectIdentifier=@"selectIdentifier";
@interface IXMSDKBasicRealNameViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    IXMSDKUserParamsModel *userParamsModel2;
    IXMConfig *config;
    NSString *placeholder;
    NSInteger currentIndex;
    NSInteger currentAddImage;
    
    NSArray *placeholderArray2;
    NSMutableArray *arrayDataSouce2;
    
    UITableView *pageView;
    UIButton  *sendBtn;
    UITextField * selectedField;
}
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation IXMSDKBasicRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //参数
    userParamsModel2=[IXMSDKUserParamsModel new];
    NSDictionary * user =self.userDic[@"result"][@"user"];
    userParamsModel2 = [IXMSDKUserParamsModel mj_objectWithKeyValues:user];
    self.fd_prefersNavigationBarHidden =YES;


    
    config=[IXMConfig globalConfig];
    
    currentIndex= 0;
    
    currentAddImage =0;
    placeholderArray2=@[@"请输入用户名(必填)",@"请输入真实姓名(必填)",@"请输入身份证号码(必填)"];
    arrayDataSouce2=[NSMutableArray new];
    
    for (int i =0; i<placeholderArray2.count; i++) {
        [arrayDataSouce2 addObject:@""];
    }
    
    self.view.backgroundColor =[UIColor whiteColor];
    //头部
    [self sethead];
    
    pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    [pageView registerClass:[IXMSDKSelectCell class] forCellReuseIdentifier:selectIdentifier];
    pageView.delegate = self;
    pageView.dataSource = self;
    [self.view addSubview:pageView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [pageView addGestureRecognizer:_tap];

}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [selectedField resignFirstResponder];
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
-(void)sethead{
    
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
    titleLable.text=@"初级实名认证";
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
}

#pragma mark- 表格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.tag = indexPath.row;
    
    [cell setPlaceholderString:placeholderArray2[indexPath.row]  andIndexPath:indexPath];
    NSString *indexstr =arrayDataSouce2[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    
    IXMSDKSelectCell *scell = [[IXMSDKSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectIdentifier];
    scell.titleText=placeholder;
    scell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.textField.userInteractionEnabled =NO;
        [arrayDataSouce2 replaceObjectAtIndex:indexPath.row withObject:userParamsModel2.userName];
        [cell setString:userParamsModel2.userName andIndexPath:indexPath];
    }
    
    if (indexPath.row==1) {
        
        [cell setString:userParamsModel2.certificateName andIndexPath:indexPath];
    }
    if (indexPath.row==2) {
        
        [cell setString:userParamsModel2.certificateNum andIndexPath:indexPath];
    }
    cell.textField.delegate = self;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 60)];
    footView.backgroundColor =[UIColor whiteColor];
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
        make.bottom.equalTo(footView).offset(-10);
        
    }];
    return  footView;
}
#pragma mark - private
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    selectedField =textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger indexPath = textField.tag;
    if (arrayDataSouce2.count > indexPath) {
        [arrayDataSouce2 replaceObjectAtIndex:indexPath withObject:textField.text];
    }
}

//发送验证码
-(void)sendAction{
    [SVProgressHUD show];
    if (![[IXMSDKToolManager shareSession] isTelephone:userParamsModel2.mobile] ) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    IXMSDKUserParamsModel * sendSmsModel=[IXMSDKUserParamsModel new];
    sendSmsModel.mobile = userParamsModel2.mobile;
    sendSmsModel.confirmType = @"999";
    sendSmsModel.userName = userParamsModel2.userName;
    
    [IXMsSDKRequest GetSmscodeWithModel:sendSmsModel suncess:^(id suncess) {
        
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

- (void)hiddenKeyBord{
    
    [self.view endEditing:YES];
}
-(void)submit{
    [selectedField resignFirstResponder];
    [arrayDataSouce2 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case 0:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel2.userName = str;
                }
                
                break;
                
            case 1:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel2.trueName = str;
                }
                
                break;
                
            case 2:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel2.creditID = str;
                }
                
                break;
            default:
                break;
        }
        
    }];
    
    //姓名
    
    if (userParamsModel2.userName.length<3 || userParamsModel2.userName.length>20 ) {
        [SVProgressHUD showErrorWithStatus:@"用户名需以字母开头，支持字母、数字、下划线组合，长度为3-20个字符"];
        return;
    }
    if (userParamsModel2.trueName.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (userParamsModel2.creditID.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号码"];
        return;
    }

    userParamsModel2.email = nil;
    userParamsModel2.mobile = nil;
    userParamsModel2.uuid = nil;
    userParamsModel2.gender = nil;
    [SVProgressHUD show];
    [IXMsSDKRequest RealBasickNameModel:userParamsModel2 suncess:^(id callback) {
        [self backAction];
    } failure:^(id callback) {
    
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        if (userParamsModel2.email.length==0) {
            return 0;
        }
    }
    return 48;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

@end
