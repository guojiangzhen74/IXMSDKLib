//
//  IXMSDKSecurityViewController.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/7/31.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKSecurityViewController.h"
#import "Masonry.h"
#import "IXMConfig.h"
#import "IXMSDKConfing.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "IXMSDKLoginCell.h"
#import "IXMSDKSelectCell.h"
#import "IXMSDKAccountManager.h"
static NSString *Identifier=@"Identifier";
static NSString *Identifier1=@"Identifier1";
@interface IXMSDKSecurityViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    IXMConfig *ixmconfig;
    
    NSMutableArray * DataArray;
    
    
    NSMutableArray * questDataArray;
    NSMutableArray * questArray;
    NSMutableArray * answerArray;
    UITableView *pageView;
    UIPickerView *pickView ;
    UIDatePicker * dataPick;
    
    NSInteger selectQusetCount;
    
    NSString * questOne;
    NSString * questTow;
    NSString * questThree;
    //被选中的字符串
    NSString * resultStr;
    
    UITextField * selectedField;
    
    UITextField * timeField;
    NSDictionary * accountInfo;
    
    
    NSInteger selectedRow;
}

@end

@implementation IXMSDKSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    accountInfo = [IXMSDKAccountManager shareSession].accountInfo;
    DataArray= [NSMutableArray new];
    questDataArray = [NSMutableArray new];
    questArray  = [NSMutableArray new];
    answerArray  = [NSMutableArray new];
    questOne = @"";
    questTow = @"";
    questThree = @"";
    resultStr = @"请选择密保问题";
    
    
    NSArray * quest1 = [NSArray arrayWithObjects:@"您母亲的姓名是？",@"您父亲的姓名是？",@"您配偶的姓名是？", nil];
    NSArray * quest2 = [NSArray arrayWithObjects:@"您母亲的生日是？",@"您父亲的生日是？",@"您配偶的生日是？", nil];
    NSArray * quest3 = [NSArray arrayWithObjects:@"您高中班主任的姓名是？？",@"您小学班主任的姓名是？",@"您初中班主任的姓名是？", nil];
    
    [DataArray addObjectsFromArray:quest1];
    [DataArray addObjectsFromArray:quest2];
    [DataArray addObjectsFromArray:quest3];
    
    [questDataArray addObjectsFromArray:quest1];
    [questDataArray addObjectsFromArray:quest2];
    [questDataArray addObjectsFromArray:quest3];
    
    
    NSArray * answer = [NSArray arrayWithObjects:@"请选择密保问题",@"请选择密保问题",@"请选择密保问题", nil];
    [questArray setArray:answer];
    NSArray * answer2 = [NSArray arrayWithObjects:@"",@"",@"", nil];
    [answerArray setArray:answer2];
    
    
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
    
    ixmconfig=[IXMConfig globalConfig];
    
    
    
    UIView *barView=[UIView new];
    barView.backgroundColor =ixmconfig.IXMSDKnavBackgroundColor;
    [self.view addSubview:barView];
    
    
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(IXMSDKScreenWith);
        make.height.mas_equalTo(64);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
        
    }];
    
    UILabel *titleLable=[UILabel new];
    titleLable.text=@"密保";
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
    
    
    pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier1];
    
    pageView.delegate = self;
    pageView.dataSource = self;
    [self.view addSubview:pageView];
    [self setTableViewFootView:pageView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
-(void)setTableViewFootView:(UITableView *)tableView{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 200)];
    
    //提交
    UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sumitbtn setBackgroundColor:ixmconfig.IXMSDKnavBackgroundColor];
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
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [footView addGestureRecognizer:tap];
    
    tableView.tableFooterView =footView;
    
}
-(void)hideKeyBoard{
    [self.view endEditing:YES];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.row+1) % 2) {
        IXMSDKSelectCell *cell = [[IXMSDKSelectCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleText = [NSString stringWithFormat:@"问题%ld:  %@",1+indexPath.row/2,questArray[indexPath.row/2]];
        
        return cell;
    }else{
        IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.userInteractionEnabled = YES;
        cell.textField.delegate = self;
        cell.textField.tag = indexPath.row/2;
        return cell;
    }
}
#pragma mark - private
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyBoard];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    selectedField = textField;
}

- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    
    [answerArray replaceObjectAtIndex:indexPath withObject:textField.text];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hideKeyBoard];
    if (indexPath.row==0||indexPath.row==2||indexPath.row==4) {
        selectQusetCount = indexPath.row/2;
        NSInteger selectedIn=-1;
        resultStr = questDataArray[0];
        [questDataArray setArray:DataArray];
        if (selectQusetCount ==0) {
            if (questTow.length>0) {
                [questDataArray removeObject:questTow];
            }
            if (questThree.length>0) {
                [questDataArray removeObject:questThree];
            }
            if (questOne.length>0) {
                selectedIn = [questDataArray indexOfObject:questOne];
                resultStr = questOne;
            }else{
                resultStr = questDataArray[0];
            }
        }else if(selectQusetCount==1){
            if (questOne.length>0) {
                [questDataArray removeObject:questOne];
            }
            if (questThree.length>0) {
                [questDataArray removeObject:questThree];
            }
            if (questTow.length>0) {
                selectedIn = [questDataArray indexOfObject:questTow];
                resultStr = questTow;
            }else{
                resultStr = questDataArray[0];

            }
        }else{
            if (questTow.length>0) {
                [questDataArray removeObject:questTow];
            }
            if (questOne.length>0) {
                [questDataArray removeObject:questOne];
            }
            if (questThree.length>0) {
                selectedIn = [questDataArray indexOfObject:questThree];
                resultStr = questThree;
            }else{
                resultStr = questDataArray[0];
                
            }
        }
        
        
        NSString *version = [UIDevice currentDevice].systemVersion;
        NSString * nstr;
        if (version.doubleValue < 10.0) {
            nstr = @"\n\n\n\n\n\n\n\n\n\n";
        }else{
            nstr = @"\n\n\n\n\n\n\n";
        }
        UIAlertController * sheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"请选择问题%ld",1+indexPath.row/2] message:nstr preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * canal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            resultStr = @"请选择密保问题";
        }];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (![resultStr  isEqualToString:@"请选择密保问题"]) {
                
                if (selectQusetCount ==0) {
                    questOne = resultStr;
                }else if(selectQusetCount==1){
                    questTow = resultStr;
                }else{
                    questThree =resultStr;
                }
                [questArray replaceObjectAtIndex:selectQusetCount withObject:resultStr];
                resultStr = @"请选择密保问题";
                [pageView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        }];
        [sheet addAction:canal];
        [sheet addAction:sure];
        
        
        pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, IXMSDKScreenWith, 160)];
        pickView.dataSource = self;
        pickView.delegate = self;
        [sheet.view addSubview:pickView];
        
        if (selectedIn>=0) {
            [pickView selectRow:selectedIn inComponent:0 animated:YES];
            selectedRow =selectedIn;
        }else{
            selectedRow = 0;
        }
        
        [self presentViewController:sheet animated:YES completion:nil];
    }
    
    
}
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return questDataArray.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return questDataArray[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
        
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    if (row == selectedRow) {
        pickerLabel.attributedText
        = [self pickerView:pickerView attributedTitleForRow:selectedRow forComponent:component];
    }else{
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    return pickerLabel;
}
// 选中行显示在label上
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * result = questDataArray[row];
    resultStr = result;
    selectedRow = row;
    [pickerView selectRow:selectedRow inComponent:0 animated:YES];
    [pickerView reloadComponent:0];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleString =questDataArray[row];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:titleString];
    NSRange range = [titleString rangeOfString:titleString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:range];
    return attributedString;
}
-(void)submit{
    if ([questArray[0] isEqualToString:@"请选择密保问题"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择问题1"];
        return;
    }
    if ([answerArray[0] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写问题1答案"];
        return;
    }
    if ([questArray[1] isEqualToString:@"请选择密保问题"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择问题2"];
        return;
    }
    if ([answerArray[1] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写问题2答案"];
        return;
    }
    if ([questArray[2] isEqualToString:@"请选择密保问题"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择问题3"];
        return;
    }
    if ([answerArray[2] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写问题3答案"];
        return;
    }
    NSString * usernName = accountInfo[@"result"][@"user"][@"userName"];
    [SVProgressHUD show];
    [IXMsSDKRequest changeUserPWDLockModel:usernName questions:questArray answers:answerArray suncess:^(id sucess) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id erro) {
        
    }];
}

@end
