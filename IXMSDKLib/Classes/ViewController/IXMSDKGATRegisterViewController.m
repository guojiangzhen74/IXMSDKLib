//
//  IXMGATRegisterViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/28.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKGATRegisterViewController.h"
#import "IXMSDKConfing.h"
#import "IXMConfig.h"
#import "Masonry.h"
#import "IXMSDKLoginCell.h"
#import "IXMsSDKRequest.h"
#import "IXMSDKUserParamsModel.h"
#import "IXMSDKSelectCell.h"
#import "IXMSDKPickerView.h"
#import "IXMSDKWebViewController.h"
#import "IXMSDKAccountManager.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
static NSString *Identifier=@"Identifier";
static NSString *selectIdentifier=@"selectIdentifier";
@interface IXMSDKGATRegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    IXMSDKUserParamsModel *userParamsModel1;
    IXMSDKUserParamsModel *userParamsModel2;
    NSArray *titleArray;
    NSArray *placeholderArray1;
    NSMutableArray *arrayDataSouce1;
    NSArray *placeholderArray2;
    NSMutableArray *arrayDataSouce2;
    
    UIButton  *sendBtn;
    IXMConfig *config;
    UITableView *pageView;
    NSString *placeholder;
    NSInteger currentIndex;
    NSMutableArray *imageViews;
    UIView *lineView;
    
     NSInteger currentAddImage;
    
    NSMutableArray *images;

    BOOL isRenZheng;
}

@end


@implementation IXMSDKGATRegisterViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    isRenZheng = NO;
    self.fd_prefersNavigationBarHidden =YES;

    
    config=[IXMConfig globalConfig];
    
    placeholder=@"港澳通行证";
    
    currentIndex= 0;
    
    currentAddImage =0;
    placeholderArray1=@[@"请输入用户名(必填)",@"请输入手机号码(必填)",@"请输入手机验证码(必填)",@"请输入密码(必填)",@"重复输入密码(必填)",@"请输入邮箱",@"请输入真实姓名",@"请输入身份证号码"];
//     placeholderArray1=@[@"请输入用户名(必填)",@"请输入手机号码(必填)",@"请输入手机验证码(必填)",@"请输入密码(必填)",@"重复输入密码(必填)",@"请输入真实姓名",@"请输入身份证号码"];
    arrayDataSouce1=[NSMutableArray new];
    
    for (int i =0; i<placeholderArray1.count; i++) {
        [arrayDataSouce1 addObject:@""];
    }
    
    
    placeholderArray2=@[@"请输入用户名(必填)",@"请输入手机号码(必填)",@"请输入手机验证码(必填)",@"请输入密码(必填)",@"重复输入密码(必填)",@"请输入邮箱",@"请输入真实姓名(必填)",@"请选择证件类型(必选)",@"请输入证件号码(必填)"];
    arrayDataSouce2=[NSMutableArray new];
    imageViews=[NSMutableArray new];
    
    for (int i =0; i<placeholderArray2.count; i++) {
        [arrayDataSouce2 addObject:@""];
    }
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    images=[NSMutableArray new];
    
    for (int i =0; i<3; i++) {
        [images addObject:@""];
    }
    
    //头部
    [self sethead];
    
    
    pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64+44, IXMSDKScreenWith, IXMSDKScreenHeight-64-44) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    [pageView registerClass:[IXMSDKSelectCell class] forCellReuseIdentifier:selectIdentifier];
    pageView.delegate = self;
    pageView.dataSource = self;
        
    [self.view addSubview:pageView];
    
    //参数
    userParamsModel1=[IXMSDKUserParamsModel new];
    userParamsModel2=[IXMSDKUserParamsModel new];
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
    titleLable.text=@"注册";
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
    
    

    

    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, IXMSDKScreenWith, 44)];
    headView.backgroundColor =IXMRGB(245, 245, 245, 1);
    [self.view addSubview:headView];
    
    NSArray *titles=@[@"大陆用户",@"港澳台胞注册"];
    
    [titles enumerateObjectsUsingBlock:^(NSString  *str, NSUInteger idx, BOOL * _Nonnull stop) {
        //标题
        UILabel *titleLable=[UILabel new];
        titleLable.text =str;
        titleLable.tag =idx;
        titleLable.font =[UIFont systemFontOfSize:14];
        if (idx == 0) {
            titleLable.textColor =config.IXMSDKnavBackgroundColor;
        }
        titleLable.textAlignment= NSTextAlignmentCenter;
        titleLable.userInteractionEnabled =YES;
        [headView addSubview:titleLable];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(IXMSDKScreenWith/2);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(headView);
            make.left.equalTo(headView).offset(idx*IXMSDKScreenWith/2);
        }];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textAction:)];
        
        [titleLable addGestureRecognizer:tap];
        
        
    }];
    
    lineView =[[UIView alloc]initWithFrame:CGRectMake(50, 64+42, IXMSDKScreenWith/4, 2)];
    lineView.backgroundColor = config.IXMSDKnavBackgroundColor;
    [self.view addSubview:lineView];
    
}

-(void)textAction:(UITapGestureRecognizer *)tap{

    NSInteger lableCurrentIndex = tap.view.tag;
    currentIndex = lableCurrentIndex;
    [pageView reloadData];
    
    switch (lableCurrentIndex) {
        case 0:
        {
        [UIView animateWithDuration:0.25 animations:^{
            [lineView setFrame:CGRectMake(50, 64+42, IXMSDKScreenWith/4, 2)];
            
        } completion:^(BOOL finished) {
            
            [lineView setFrame:CGRectMake(50, 64+42, IXMSDKScreenWith/4, 2)];

        }];
        
        }
            break;
            
        case 1:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [lineView setFrame:CGRectMake(IXMSDKScreenWith/2+50, 64+42, IXMSDKScreenWith/4, 2)];
                
            } completion:^(BOOL finished) {
                
                [lineView setFrame:CGRectMake(IXMSDKScreenWith/2+50, 64+42, IXMSDKScreenWith/4, 2)];
                
            }];
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark- 表格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (currentIndex) {
        case 0:
            return 8;
            break;
            
        case 1:
            return 9;
            break;
            
        default:
            return 0;
            break;
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textField.tag =indexPath.row;
    
    if (currentIndex == 0) {
        [cell setPlaceholderString:placeholderArray1[indexPath.row]  andIndexPath:indexPath];
        NSString *indexstr =arrayDataSouce1[indexPath.row];
        if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
            [cell setString:indexstr andIndexPath:indexPath];
        }

    }else{
        
        [cell setPlaceholderString:placeholderArray2[indexPath.row]  andIndexPath:indexPath];
        NSString *indexstr =arrayDataSouce2[indexPath.row];
        if (![indexstr isEqualToString:@""] && indexstr.length > 0 ) {
            [cell setString:indexstr andIndexPath:indexPath];
        }
    }
    //邮箱隐藏
    if (indexPath.row==5) {
        [cell.textField setHidden:YES];
        cell.textField.userInteractionEnabled = NO;
    }
   
    IXMSDKSelectCell *scell = [[IXMSDKSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectIdentifier];
    scell.titleText=placeholder;
    scell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    
    
    if (indexPath.row ==2) {
        cell.isshowbtn=YES;
        sendBtn = cell.sendbtn;
        [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (indexPath.row ==3 || indexPath.row ==4) {
        cell.ispwd =YES;
    }
    
    //下拉项
    if (indexPath.row == 7 && currentIndex ==1) {
        return scell;
    }else{
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==7 && currentIndex ==1) {
        [self hiddenKeyBord];
        IXMSDKPickerView *pickerView = [[IXMSDKPickerView alloc] initWithDataSource:@[@"港澳通行证",@"台胞证",@"护照"]
                                                           withSelectedItem:@"台胞证"
                                                          withSelectedBlock:^(id selectedItem) {
                                                            
                                                              placeholder = selectedItem;
                                                              NSArray *indexPaths=@[indexPath];
                                                              
                                                              [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                                                              
                                                          }
                                    ];
        
        [pickerView show];

    }
 
}

#pragma mark - private


- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值

    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    
    if (currentIndex == 0) {
        if (arrayDataSouce1.count > indexPath) {
            [arrayDataSouce1 replaceObjectAtIndex:indexPath withObject:textField.text];
        }
        
    }else{
    
        if (arrayDataSouce2.count > indexPath) {
            [arrayDataSouce2 replaceObjectAtIndex:indexPath withObject:textField.text];
        }
        
    
    }
}

- (void)hiddenKeyBord{
    
    [self.view endEditing:YES];
}

#pragma  mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag ==2000) {
        if(buttonIndex == 0){
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self takePhoto];
            }else{
            
            }
        }else if(buttonIndex == 1){
            [self LocalPhotoLibrary];
        }
    }
    
}
// 开始拍照
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        // 设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
// 打开本地相册
- (void)LocalPhotoLibrary {
    // 创建图像选取控制器对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 将资源类型设置为相册类型
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 将媒体类型设置为图片类型和视频类型(数组中如果只写一个,图像选择控制器即只能选取图片/视频)
    picker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    // 设置选取后的图片允许编辑
    picker.allowsEditing = YES;
    // 设置代理,需要遵守<UINavigationControllerDelegate, UIImagePickerControllerDelegate>两个协议
    picker.delegate = self;
    // 弹出图像选取控制器
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)pickPhotoAction:(NSInteger)tag {
    [self.view endEditing:YES];
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册上传", nil];
    menu.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    menu.tag =2000;
    [menu showInView:self.view];
}
#pragma mark 相册
-(void)imageAction:(UITapGestureRecognizer *)tap{
    
    
    UIImageView *imageView=(UIImageView*)tap.view;
    currentAddImage = imageView.tag;
    [self pickPhotoAction:currentAddImage];
}
#pragma mark ------ UIImagePickerControllerDelegate --------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
 
    UIImageView *imageView=imageViews[currentAddImage];
    imageView.contentMode = UIViewContentModeScaleToFill;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [imageView setImage:image];
    [images replaceObjectAtIndex:currentAddImage withObject:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 操作取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 回收图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//发送验证码
-(void)sendAction{
    [SVProgressHUD show];
    if (currentIndex == 0) {
        if ([arrayDataSouce1[1] isEqualToString:@""] || ![[IXMSDKToolManager shareSession] isTelephone:arrayDataSouce1[1]] ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }else{
            
            userParamsModel1.mobile =arrayDataSouce1[1];
        }
        IXMSDKUserParamsModel * sendSmsModel=[IXMSDKUserParamsModel new];
        sendSmsModel.mobile = userParamsModel1.mobile;
        sendSmsModel.confirmType = userParamsModel1.confirmType;
        [IXMsSDKRequest GetSmscodeWithModel:sendSmsModel suncess:^(id suncess) {
            [self startTime];
        } failure:^(id error) {
            
            
        }];
        
    }else{
    
        if ([arrayDataSouce2[1] isEqualToString:@""] || ![[IXMSDKToolManager shareSession] isTelephone:arrayDataSouce2[1]] ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }else{
            
            userParamsModel2.mobile =arrayDataSouce2[1];
        }
        IXMSDKUserParamsModel * sendSmsModel=[IXMSDKUserParamsModel new];
        sendSmsModel.mobile = userParamsModel2.mobile;
        sendSmsModel.confirmType = userParamsModel2.confirmType;
        
        [IXMsSDKRequest GetSmscodeWithModel:sendSmsModel suncess:^(id suncess) {
            [self startTime];
        } failure:^(id error) {
            
            
        }];
    }

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

//中级认证
-(void)realNameAction:(NSString *)userid type:(NSInteger )theType{
    IXMSDKWebViewController *vc=[IXMSDKWebViewController new];
    vc.type = self.type;
    vc.webTitle=@"实名认证";
    vc.isRegister = YES;
    vc.webUrl=[NSString stringWithFormat:@"http://www.ixm.gov.cn/dis/console/normalRealnameChoose?userId=%@",userid];
    if (theType ==0) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
        }];
    }else{
        [self.navigationController pushViewController:vc animated:YES];

    }
}
//登录提交
-(void)submit{
    
    if (currentIndex == 0) {
        
        [arrayDataSouce1 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.userName = str;
                    }
                    
                    break;
                    
                case 1:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.mobile = str;
                    }
                    
                    break;
                    
                case 2:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.code = str;
                    }
                    
                    break;
                    
                case 3:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.password = str;
                    }
                    
                    break;
                    
                case 4:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.repassword = str;
                    }
                    
                    break;
                case 5:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.email = str;
                    }
                    
                    break;
                case 6:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.trueName = str;
                    }
                    
                    break;
                case 7:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel1.creditID = str;
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
        }];
        
        //姓名
        
        if (userParamsModel1.userName.length<3 || userParamsModel1.userName.length>20 ) {
            [SVProgressHUD showErrorWithStatus:@"用户名需以字母开头，支持字母、数字、下划线组合，长度为3-20个字符"];
            return;
        }
        if ([self IsChinese:userParamsModel1.userName]) {
            [SVProgressHUD showErrorWithStatus:@"用户注册用户名不允许中文"];
            return;
        }
        //手机号码
        if ([userParamsModel1.mobile isEqualToString:@""] || ![[IXMSDKToolManager shareSession] isTelephone:userParamsModel1.mobile] ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }
        //验证码
        if ([userParamsModel1.code isEqualToString:@""] || userParamsModel1.code ==nil ) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        
        //密码
        if ([userParamsModel1.password isEqualToString:@""] || userParamsModel1.password == nil ) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
        if ([userParamsModel1.repassword isEqualToString:@""] || userParamsModel1.repassword == nil ) {
            [SVProgressHUD showErrorWithStatus:@"请重复输入密码"];
            return;
        }
        
        if (![userParamsModel1.password isEqualToString:userParamsModel1.repassword] ) {
            [SVProgressHUD showErrorWithStatus:@"两次密码不一至,请重新输入"];
            return;
        }
        if ([userParamsModel1.trueName isEqualToString:@""]|| userParamsModel1.trueName == nil) {
            [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
            return;
        }
        if ([userParamsModel1.creditID isEqualToString:@""]||userParamsModel1.creditID == nil) {
            [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
            return;
        }
        
        [SVProgressHUD show];
        //提交
        [IXMsSDKRequest RegisterWithModel:userParamsModel1 suncess:^(id suncess) {
        
            //如果要自动登录
            if (self.isLogin) {
                //登录
                IXMSDKUserParamsModel *loginParamsMode=[IXMSDKUserParamsModel new];
                loginParamsMode.userName = userParamsModel1.userName;
                loginParamsMode.password = userParamsModel1.password;
                
                    [IXMsSDKRequest LoginWithModel:loginParamsMode suncess:^(id LoginSuncess) {
                        
                        if (isRenZheng) {
                            if ([LoginSuncess[@"code"]isEqual:@1001]) {
                                [[IXMSDKAccountManager shareSession] setIsRealName:YES];
                            }
                        }
                        
                    if (_isBack) {
                        
                            self.callbackblock(LoginSuncess);

                        }else{
                            if ([_delegate respondsToSelector:@selector(loginBack:)]) { // 如果协议响应了sendValue:方法
                                [_delegate loginBack:LoginSuncess]; // 通知执行协议方法
                            }
                        }
                        switch (self.type) {
                            case 0:
                                [self realNameAction:LoginSuncess[@"result"][@"user"][@"userId"] type:self.type];
                                break;
                            case 1:
                                [self realNameAction:LoginSuncess[@"result"][@"user"][@"userId"] type:self.type];
                                break;
                            default:
                                break;
                        }

                    } failure:^(id error) {
                        self.callbackblock(error);
                        
                    }];
                
            }else{
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

        
        
    }else{
    
        [arrayDataSouce2 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.userName = str;
                    }
                    
                    break;
                    
                case 1:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.mobile = str;
                    }
                    
                    break;
                    
                case 2:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.code = str;
                    }
                    
                    break;
                    
                case 3:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.password = str;
                    }
                    
                    break;
                    
                case 4:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.repassword = str;
                    }
                    
                    break;
                case 5:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.email = str;
                    }
                    
                    break;
                case 6:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.certificateName = str;
                    }
                    
                    break;
                    
                case 8:
                    
                    if (str.length > 0 && ![str isEqualToString:@""]) {
                        userParamsModel2.certificateNum = str;
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
        if ([self IsChinese:userParamsModel2.userName]) {
            [SVProgressHUD showErrorWithStatus:@"用户注册用户名不允许中文"];
            return;
        }
        //手机号码
        if ([userParamsModel2.mobile isEqualToString:@""] || ![[IXMSDKToolManager shareSession] isTelephone:userParamsModel2.mobile] ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }
        //验证码
        if ([userParamsModel2.code isEqualToString:@""] || userParamsModel2.code ==nil ) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        
        //密码
        if ([userParamsModel2.password isEqualToString:@""] || userParamsModel2.password == nil ) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
        if ([userParamsModel2.repassword isEqualToString:@""] || userParamsModel2.repassword == nil ) {
            [SVProgressHUD showErrorWithStatus:@"请重复输入密码"];
            return;
        }
        
        if (![userParamsModel2.password isEqualToString:userParamsModel2.repassword] ) {
            [SVProgressHUD showErrorWithStatus:@"两次密码不一至,请重新输入"];
            return;
        }
        
        
        if ([placeholder isEqualToString:@"证件类型"] ) {
            [SVProgressHUD showErrorWithStatus:@"请选择正件类型"];
            return;
        }else{
        
            if ([placeholder isEqualToString:@"港澳通行证"]) {
                userParamsModel2.certificateType=@"gapass";
            }else if([placeholder isEqualToString:@"台胞证"]){
                userParamsModel2.certificateType=@"twpass";
            }else{
                userParamsModel2.certificateType=@"passport";
            }
        
        }
        if ([userParamsModel2.certificateNum isEqualToString:@""]||userParamsModel2.certificateNum == nil ) {
            [SVProgressHUD showErrorWithStatus:@"请输入证件号码"];
            return;
        }
        
      __block  bool isHasImage1 = NO;
      __block  bool isHasImage2 = NO;
      __block  bool isHasImage3 = NO;
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                    if (![obj isKindOfClass:[UIImage class]]) {
                        [SVProgressHUD showErrorWithStatus:@"请选择证件正面照!"];
                        isHasImage1 = NO;
                    }else{
                        isHasImage1 = YES;
                    }
                    break;
                case 1:
                    if (![obj isKindOfClass:[UIImage class]]) {
                        [SVProgressHUD showErrorWithStatus:@"请选择证件反面照!"];
                        isHasImage2 = NO;
                    }else{
                        isHasImage2 = YES;
                    }
                    break;
                
                case 2:
                    if (![obj isKindOfClass:[UIImage class]]) {
                        [SVProgressHUD showErrorWithStatus:@"请选择用户持证照!"];
                        isHasImage3 = NO;
                    }else{
                        isHasImage3 = YES;
                    }
                    break;
                    
                default:
                    break;
            }
            
        }];
        
        
        if (!isHasImage1 || !isHasImage2 || !isHasImage3) {
            return;
        }
        [SVProgressHUD show];

        //提交
        [IXMsSDKRequest GATRegisterWithModel:userParamsModel2 file:[self Image_TransForm_Data:images[0]] backFile:[self Image_TransForm_Data:images[1]] handleFile:[self Image_TransForm_Data:images[2]] suncess:^(id suncess) {
            if (_isBack) {
                self.callbackblock(suncess);
            }
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
       
        }];
    }    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     //邮箱隐藏
    if (currentIndex ==0 && indexPath.row==5) {
        return 0;
    }
    if (currentIndex ==1 && indexPath.row==5) {
        return 0;
    }
    return 48;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    switch (currentIndex) {
        case 0:
            return 140;
            break;
        case 1:
            return (IXMSDKScreenWith/3-30)+44+66;
            break;
        default:
            return  0;
            break;
    }

}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (currentIndex == 0) {
        
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 140)];
//          footView.backgroundColor =[UIColor whiteColor];
        
        NSBundle * bundle = [PodAsset bundleForPod:@"IXMSDKLib"];
        UIImage * imged = [UIImage imageNamed:@"ixm_checked@2x"  inBundle: bundle compatibleWithTraitCollection:nil ];
        UIImage * imgempt = [UIImage imageNamed:@"ixm_empty_check@2x"  inBundle: bundle compatibleWithTraitCollection:nil ];

        //提交
        UIButton * checkBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [checkBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        [checkBtn setSelected:NO];
        
        [checkBtn setImage:imgempt forState:UIControlStateNormal];
        [checkBtn setImage:imged forState:UIControlStateSelected];

        [footView addSubview:checkBtn];
        [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(footView).offset(10);
            make.top.equalTo(footView).offset(10);
            
        }];
        UILabel * messageLabel = [[UILabel alloc]init];
        messageLabel.text = @"是否实人认证";
        [messageLabel setFont:[UIFont systemFontOfSize:14]];
        [footView addSubview:messageLabel];
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(checkBtn).offset(40);
            make.centerY.equalTo(checkBtn);
        }];
        UILabel * messageLabel2 = [[UILabel alloc]init];
        messageLabel2.text = @"(温馨提示:部分业务需要实名认证才能使用)";
        [messageLabel2 setFont:[UIFont systemFontOfSize:14]];
        [footView addSubview:messageLabel2];
        
        [messageLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footView).offset(10);
            make.top.equalTo(footView).offset(40);
        }];
        
        
        UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [sumitbtn setBackgroundColor:config.IXMSDKnavBackgroundColor];
        [sumitbtn setTitle:@"注册" forState:UIControlStateNormal];
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
        
        return  footView;
        
        
    }else{
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, IXMSDKScreenWith, 200)];
        footView.backgroundColor =[UIColor whiteColor];
        
        [imageViews removeAllObjects];
        
        NSArray *titles=@[@"证件正面照",@"证件反面照",@"用户持证照"];
        
        [titles enumerateObjectsUsingBlock:^(NSString  *str, NSUInteger idx, BOOL * _Nonnull stop) {
            //标题
            UILabel *titleLable=[UILabel new];
            titleLable.text =str;
            titleLable.font =[UIFont systemFontOfSize:14];
            titleLable.textColor =config.IXMSDKnavBackgroundColor;
            titleLable.textAlignment= NSTextAlignmentCenter;
            [footView addSubview:titleLable];
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(IXMSDKScreenWith/3);
                make.top.equalTo(footView).offset(15);
                make.left.equalTo(footView).offset(idx*IXMSDKScreenWith/3);
            }];
            
            NSBundle * bundle = [PodAsset bundleForPod:@"IXMSDKLib"];
            UIImage * img= [UIImage imageNamed:@"hcclose@3x"  inBundle: bundle compatibleWithTraitCollection:nil];
            UIImageView *imageview=[UIImageView new];
            imageview.tag = idx;
            imageview.layer.borderWidth =0.5;
            imageview.layer.borderColor =IXMRGB(200, 200, 200, 1).CGColor;
            imageview.layer.masksToBounds =YES;
            imageview.layer.cornerRadius=4;
            imageview.contentMode = UIViewContentModeCenter;
            [imageview setImage:img];
            imageview.userInteractionEnabled =YES;
            
            [imageViews addObject:imageview];
            
            //重设置图片
            if ([images[idx] isKindOfClass:[UIImage class]]) {
                [imageview setImage:images[idx]];
            }
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)];
            [imageview addGestureRecognizer:tap];
            
            [footView addSubview:imageview];
            
            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(IXMSDKScreenWith/3-30);
                make.height.mas_equalTo(IXMSDKScreenWith/3-30);
                make.top.equalTo(footView).offset(45);
                make.centerX.equalTo(titleLable);
            }];
            
            
        }];
        
        
        //提交
        UIButton *sumitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [sumitbtn setBackgroundColor:config.IXMSDKnavBackgroundColor];
        [sumitbtn setTitle:@"注册" forState:UIControlStateNormal];
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

}

-(IBAction)checkAction:(UIButton *)sender{
    if (sender.isSelected) {
        isRenZheng = NO;
        [sender setSelected:NO];
    }else{
        isRenZheng = YES;
        [sender setSelected:YES];
    }
}

#pragma mark- 键盘事件
-(void)KeyboardWillShow:(NSNotification *)notification{
    CGSize keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    pageView.frame=CGRectMake(0, 64+44, IXMSDKScreenWith, IXMSDKScreenHeight-64-44-keyboard.height);
    
}
-(void)KeyboardWillHide:(NSNotification *)notification{
    
    pageView.frame=CGRectMake(0, 64+44, IXMSDKScreenWith, IXMSDKScreenHeight-64-44);
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSLog(@"register");
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
    
    NSLog(@"remove");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


-(NSData *)Image_TransForm_Data:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image , 0.5);
    //几乎是按0.5图片大小就降到原来的一半 比如这里 24KB 降到11KB
    return imageData;
}

//1、判断输入的字符串是否有中文

-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return YES;
        }
    }
    return NO;
}

@end
