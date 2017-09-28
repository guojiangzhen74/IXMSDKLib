//
//  IXMRealPersonAuthentication.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/10.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKRealPersonAuthentication.h"
#import "IXMConfig.h"
#import "Masonry.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKConfing.h"
#import "IXMSDKAccountManager.h"
//#import "WebSignSDKManager.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "IXMSDKLoginCell.h"
static NSString *Identifier=@"Identifier";


@interface IXMSDKRealPersonAuthentication ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{//WebSignSDKManagerDelegate,

    IXMConfig *config;
    NSDictionary * accountInfo;
    
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    BOOL hasLevl1;
    
}
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idcardTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankcardTextField;


@end

@implementation IXMSDKRealPersonAuthentication

- (void)viewDidLoad {
    [super viewDidLoad];
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
    config=[IXMConfig globalConfig];
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
    titleLable.text=@"实名认证";
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
    
    config=[IXMConfig globalConfig];
    
    accountInfo = [IXMSDKAccountManager shareSession].accountInfo;
    
    
    placeholderArray=@[@"请输入姓名",@"请输入身份证号码",@"请输入手机号码",@"请输入银联卡号"];
    arrayDataSouce=[NSMutableArray new];
    [arrayDataSouce addObject:@""];
    [arrayDataSouce addObject:@""];
    [arrayDataSouce addObject:[IXMSDKAccountManager shareSession].mobile];
    [arrayDataSouce addObject:@""];
    
    //初始化列表
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [_tableView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setTableViewFootView:self.tableView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBord)];
    [self.tableView addGestureRecognizer:gesture];
    
     hasLevl1 = NO;
    NSDictionary *result=accountInfo[@"result"];
    if (![result isEqual:@"获取失败"]) {
        if ([result[@"user"][@"realNameStatus"] isEqualToString:@"PASSED_NOTREALNAME"]) {
            return;
        }
    }

    hasLevl1 = YES;
    [arrayDataSouce replaceObjectAtIndex:0 withObject:result[@"user"][@"certificateName"]];
    [arrayDataSouce replaceObjectAtIndex:1 withObject:result[@"user"][@"certificateNum"]];
    
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

#pragma mark - private


- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    [arrayDataSouce replaceObjectAtIndex:indexPath withObject:textField.text];
}

- (void)hiddenKeyBord{
    [self.view endEditing:YES];
}

#pragma mark- 表格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.tag = indexPath.row;
    NSString *indexstr =arrayDataSouce[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    
    switch (indexPath.row) {
        case 0:
            if (hasLevl1) {
                cell.textField.userInteractionEnabled = NO;
            }
            break;
        case 1:
            if (hasLevl1) {
                cell.textField.userInteractionEnabled = NO;
            }
            break;
        case 2:
            cell.textField.userInteractionEnabled = NO;
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
    
    [cell setPlaceholderString:placeholderArray[indexPath.row]  andIndexPath:indexPath];

    return cell;
    
}


-(void)setTableViewFootView:(UITableView *)tableView{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 200)];
    
    //提交
    UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sumitbtn setBackgroundColor:config.IXMSDKnavBackgroundColor];
    [sumitbtn setTitle:@"下一步" forState:UIControlStateNormal];
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
//登录提交
-(void)submit{
    BOOL isOK = YES;
    for (NSInteger i=0; i<4; i++) {
        NSString * str = arrayDataSouce[i];
        if (i==0) {
            if (str.length==0) {
                isOK= NO;
                [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            }
        }
        if (i==1) {
            if (str.length==0) {
                isOK= NO;
                [SVProgressHUD showErrorWithStatus:@"请输入身份证号码"];
            }
        }
        if (i==3) {
            if (str.length==0) {
                isOK= NO;
                [SVProgressHUD showErrorWithStatus:@"请输入银联卡号"];
            }
        }
    }
    if (isOK) {
//        [[WebSignSDKManager shared]starSDKWithRealName:arrayDataSouce[0]
//                                                certId:arrayDataSouce[1]
//                                                acctNo:arrayDataSouce[3]
//                                                 phone:[IXMSDKAccountManager shareSession].mobile
//                                      isCheckBlackList:NO
//                                              platCode:@"9003"
//                                            templateNo:@"707788"
//                                         delegate:self];
    }
}
-(void)sdkWillDisAppearSign:(BOOL)success
                 contractNo:(NSString *)contractNo
                    urlPath:(NSString *)urlPath{
    if (!success) {
        [SVProgressHUD showErrorWithStatus:@"认证失败"];
    }
    NSLog(@"断点");

}

-(void)sdkDidDisappearSign:(BOOL)success
                contractNo:(NSString *)contractNo
                   urlPath:(NSString *)urlPath{
    NSLog(@"断点");

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_nameTextField) {
        [_idcardTextField becomeFirstResponder];
    }
    if (textField == _idcardTextField) {
        [_bankcardTextField becomeFirstResponder];
    }
    if (textField==_bankcardTextField) {
        
        [self submit];
    }
    return YES;
}
@end
