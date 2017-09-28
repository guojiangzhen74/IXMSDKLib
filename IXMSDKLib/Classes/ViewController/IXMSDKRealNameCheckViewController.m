//
//  IXMRealNameCheckViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/26.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKRealNameCheckViewController.h"
#import "IXMSDKConfing.h"
#import "Masonry.h"
#import "IXMSDKRealNameCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKFindPassWordViewController.h"
#import "IXMConfig.h"
#import "IXMSDKWebViewController.h"
#import "IXMSDKBasicRealNameViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
static NSString *Identifier=@"Identifier";

@interface IXMSDKRealNameCheckViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    IXMSDKUserParamsModel *userParamsModel;
    
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    NSDictionary *userDic;
    UITableView *pageView;
    IXMConfig *config;
}

@end

@implementation IXMSDKRealNameCheckViewController

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
    
    
    placeholderArray=@[@"请输入用户名/手机号",@"请输入密码"];
    arrayDataSouce=[NSMutableArray new];
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
    
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKRealNameCell class] forCellReuseIdentifier:Identifier];
    pageView.delegate = self;
    
    pageView.dataSource = self;

    
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
    IXMSDKRealNameCell  *cell = [[IXMSDKRealNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    
    NSString *status1;
    NSString *status2;
    NSString *status3;
    
    if (userDic != nil) {
        NSDictionary *result=userDic[@"result"];
        if (![result isEqual:@"获取失败"]) {
            NSDictionary *user=result[@"user"];

            if ([user[@"realNameStatus"] isEqualToString:@"PASSED_WITHREALNAME"]) {
                status3=@"已认证";
                status1=@"已认证";
                status2=@"去认证";
            }else if([user[@"realNameStatus"] isEqualToString:@"PASSED_ADVANCED"]){
                status3=@"已认证";
                status1=@"已认证";
                status2=@"已认证";
            }else if([user[@"realNameStatus"] isEqualToString:@"PASSED_BASICREALNAME"]){
                status3=@"已认证";
                status1=@"未认证";
                status2=@"未认证";
            }else{
                status3=@"未认证";
                status1=@"未认证";
                status2=@"未认证";
            }

        }
    }
    
    switch (indexPath.row) {
            case 0:
            cell.titleText = @"初级实名认证";
            cell.statusText = status3;
            break;
        case 1:
            cell.titleText=@"中级实名认证";
            cell.statusText =status1;
            break;
            
        case 2:
            cell.titleText=@"高级实名认证";
            cell.statusText =status2;
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (userDic != nil) {
        NSDictionary *result=userDic[@"result"];
        if (![result isEqual:@"获取失败"]) {
            NSDictionary *user=result[@"user"];
            if ([user[@"certificateType"] isEqualToString:@"gapass"]||[user[@"certificateType"] isEqualToString:@"twpass"]||[user[@"certificateType"] isEqualToString:@"passport"]) {
                [SVProgressHUD showErrorWithStatus:@"无法进行认证"];
                return;
            }
            
            switch (indexPath.row) {
                    case 0:
                    if ([user[@"realNameStatus"]isEqualToString:@"PASSED_NOTREALNAME"]) {
                        IXMSDKBasicRealNameViewController * vc = [IXMSDKBasicRealNameViewController new];
                        vc.userDic =userDic;
                        vc.type =self.type;
                        if (self.type ==0) {
                            [self presentViewController:vc animated:YES completion:nil];
                            
                        }else{
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }
                    break;
                case 1:
                    if ([user[@"realNameStatus"] isEqualToString:@"PASSED_BASICREALNAME"]||[user[@"realNameStatus"]isEqualToString:@"PASSED_NOTREALNAME"]) {
                        IXMSDKWebViewController *vc=[IXMSDKWebViewController new];
                        vc.type = self.type;
                        vc.webTitle=@"实名认证";
                        vc.webUrl=[NSString stringWithFormat:@"http://www.ixm.gov.cn/dis/console/normalRealnameChoose?userId=%@",user[@"userId"]];
                        [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 2:
                 if ([user[@"realNameStatus"] isEqualToString:@"PASSED_WITHREALNAME"]) {
                     IXMSDKWebViewController *vc=[IXMSDKWebViewController new];
                     vc.type = self.type;
                     vc.webUrl =[NSString stringWithFormat:@"http://www.ixm.gov.cn/dis/ids/page_high_realname?userName=suncco&userId=%@",user[@"userId"]];
                     vc.webTitle =@"高级认证";
                     [self.navigationController pushViewController:vc animated:YES];
                     
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你未进行中级实名认证,请先进行中级实名认证"];

                }
                    break;

                    
                default:
                    break;
            }
            
        }
    }
    
}

#pragma mark - private

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
    
    userParamsModel.token =self.token;
    //获取用户信息
    [IXMsSDKRequest GetUserInfoWithModel:userParamsModel suncess:^(NSDictionary    *userdic) {
        userDic = userdic;
        [pageView reloadData];
        
    } failure:^(id error) {
        
        
    }];
    
}

@end
