//
//  IXMUserInfoViewController.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/5/12.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKUserInfoViewController.h"
#import "IXMSDKConfing.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMConfig.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
static NSString *Identifier=@"Identifier";
@interface IXMSDKUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    IXMSDKUserParamsModel *userParamsModel;
    
    NSArray *titleArray;
    NSArray *placeholderArray;
    NSMutableArray *arrayDataSouce;
    UIButton  *sendBtn;
    IXMConfig *config;
    UITableView *pageView;
}

@end

@implementation IXMSDKUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =YES;

    
    config=[IXMConfig globalConfig];
    
    placeholderArray=@[@"用户名",@"真实姓名",@"绑定手机",@"",@"性别",@"生日",@"职业",@"常住社区"];
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
    titleLable.text=@"我的信息";
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
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    pageView.delegate = self;
    pageView.dataSource = self;
    [self.view addSubview:pageView];
    
    //参数
    userParamsModel=[IXMSDKUserParamsModel new];
    [self getDate];
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
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setString:placeholderArray[indexPath.row]  andIndexPath:indexPath];
    cell.textField.userInteractionEnabled = NO;
    NSString *indexstr =arrayDataSouce[indexPath.row];
    if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
        [cell setString:indexstr andIndexPath:indexPath];
    }
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    if (indexPath.row==0) {
        cell.detailTextLabel.text = userParamsModel.userName?userParamsModel.userName:@"";
    }else if (indexPath.row==1){
        cell.detailTextLabel.text = userParamsModel.certificateName?userParamsModel.certificateName:@"";
    }else if (indexPath.row==2){
        cell.detailTextLabel.text = userParamsModel.mobile?userParamsModel.mobile:@"";
    }else if (indexPath.row==3){
//        cell.detailTextLabel.text = userParamsModel.certificateNum?userParamsModel.certificateNum:@"";
    }else if (indexPath.row==4){
        if ([userParamsModel.gender isEqualToString:@"1"]) {
            cell.detailTextLabel.text = @"男";
        }else if([userParamsModel.gender isEqualToString:@"2"]){
            cell.detailTextLabel.text = @"女";
        }else{
            cell.detailTextLabel.text = @"未知";
        }
        
    }else if (indexPath.row==5){
    
    }else if (indexPath.row==6){
    
    }else{
    
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3){
        return 0;
    }
    return 48;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)completion:(CallBackBlock)block{
    self.callbackblock = block;
}
-(void)getDate{
    IXMSDKUserParamsModel *UserParamsModel=[IXMSDKUserParamsModel new];
    
    UserParamsModel.token = self.token;
    [SVProgressHUD show];
    [IXMsSDKRequest GetUserInfoWithModel:UserParamsModel suncess:^(id suncess) {
        if ([suncess[@"code"] isEqual:@1001]) {
            userParamsModel = [IXMSDKUserParamsModel mj_objectWithKeyValues:suncess[@"result"][@"user"]];
            [pageView reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"%@",suncess[@"result"]);
            self.callbackblock(suncess);
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
        
        NSLog(@"");
        
    }];
}
@end
