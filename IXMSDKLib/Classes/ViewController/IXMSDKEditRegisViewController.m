//
//  IXMEditRegisViewController.m
//  SDKTEST
//
//  Created by 郭江震 on 2017/5/5.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKEditRegisViewController.h"
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
@interface IXMSDKEditRegisViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    IXMSDKUserParamsModel *userParamsModel2;
    IXMConfig *config;
    NSString *placeholder;
    NSInteger currentIndex;
    NSInteger currentAddImage;

    NSArray *placeholderArray2;
    NSMutableArray *arrayDataSouce2;
    NSMutableArray *imageViews;
    NSMutableArray *images;
    
    UITableView *pageView;
    UIButton  *sendBtn;
    UITextField * selectedField;

}
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation IXMSDKEditRegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //参数
    userParamsModel2=[IXMSDKUserParamsModel new];
    NSDictionary * user =self.userDic[@"result"][@"user"];
    userParamsModel2 = [IXMSDKUserParamsModel mj_objectWithKeyValues:user];
    self.fd_prefersNavigationBarHidden =YES;

    
    config=[IXMConfig globalConfig];
    
    placeholder=@"证件类型";
    
    if ([userParamsModel2.certificateType isEqualToString:@"gapass"]) {
        placeholder =@"港澳通行证";
    }else if([userParamsModel2.certificateType isEqualToString:@"twpass"]){
        placeholder =@"台胞证";
    }else{
        placeholder =@"护照";
    }
    
    currentIndex= 0;
    
    currentAddImage =0;
    placeholderArray2=@[@"请输入用户名(必填)",@"请输入手机号码(必填)",@"请输入手机验证码(必填)",@"请输入邮箱",@"请输入真实姓名(必填)",@"请选择证件类型(必选)",@"请输入证件号码(必填)"];
    arrayDataSouce2=[NSMutableArray new];
    imageViews=[NSMutableArray new];
    
    for (int i =0; i<placeholderArray2.count; i++) {
        [arrayDataSouce2 addObject:@""];
    }
    
    self.view.backgroundColor =[UIColor whiteColor];
    //头部
    [self sethead];
    
    images=[NSMutableArray new];
    
    for (int i =0; i<3; i++) {
        [images addObject:@""];
    }
    
    pageView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, IXMSDKScreenWith, IXMSDKScreenHeight-64) style:UITableViewStyleGrouped];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:Identifier];
    [pageView registerClass:[IXMSDKLoginCell class] forCellReuseIdentifier:selectIdentifier];
    pageView.delegate = self;
    pageView.dataSource = self;
    [self.view addSubview:pageView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [pageView addGestureRecognizer:_tap];
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [selectedField resignFirstResponder];
}
-(void)getData{

}
-(void)backAction{
    
    switch (self.type) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            break;
            
        case 1:
            [[self navigationController] popToRootViewControllerAnimated:YES];
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
    titleLable.text=@"资料补充";
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
}

#pragma mark- 表格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IXMSDKLoginCell  *cell = [[IXMSDKLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    cell.textField.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        [cell setString:userParamsModel2.userName andIndexPath:indexPath];
    }
    
    if (indexPath.row==1) {
        cell.textField.userInteractionEnabled =NO;
        [cell setString:userParamsModel2.mobile andIndexPath:indexPath];
    }
    
    if (indexPath.row ==2) {
        cell.isshowbtn=YES;
        sendBtn = cell.sendbtn;
        [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row==3) {
        cell.textField.userInteractionEnabled =NO;
        [cell setString:userParamsModel2.email andIndexPath:indexPath];
         [cell setPlaceholderString:@"" andIndexPath:indexPath];
    }
    if (indexPath.row==4) {
        
        [cell setString:userParamsModel2.certificateName andIndexPath:indexPath];
    }
    if (indexPath.row==5) {

        [cell setString:placeholder andIndexPath:indexPath];
    }
    if (indexPath.row==6) {
        
        [cell setString:userParamsModel2.certificateNum andIndexPath:indexPath];
    }
    cell.textField.delegate = self;

    //下拉项
    if (indexPath.row == 5 && currentIndex ==0) {
        return scell;
    }else{
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==5) {
        [self hiddenKeyBord];
        IXMSDKPickerView *pickerView = [[IXMSDKPickerView alloc] initWithDataSource:@[@"港澳通行证",@"台胞证",@"护照"]
                                                           withSelectedItem:@"台胞证"
                                                          withSelectedBlock:^(id selectedItem) {
                                                              
                                                              placeholder = selectedItem;
                                                              //NSArray *indexPaths=@[indexPath];
                                                              
                                                              [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                                                              
                                                          }
                                    ];
        
        [pickerView show];
        
    }
    
}
#pragma mark - private
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    selectedField =textField;
}

- (void)textFieldDidChanged:(NSNotification *)noti{
    // 数据源赋值
    UITextField *textField=noti.object;
    NSInteger indexPath = textField.tag;
    if (arrayDataSouce2.count > indexPath) {
        [arrayDataSouce2 replaceObjectAtIndex:indexPath withObject:textField.text];
    }
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
                
            case 4:
                
                if (str.length > 0 && ![str isEqualToString:@""]) {
                    userParamsModel2.certificateName = str;
                }
                
                break;
                
            
            case 6:
                
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
    //验证码
    if ([userParamsModel2.code isEqualToString:@""] || userParamsModel2.code ==nil ) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
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
    [IXMsSDKRequest editUserInfoModel:userParamsModel2 file:[self Image_TransForm_Data:images[0]] backFile:[self Image_TransForm_Data:images[1]] handleFile:[self Image_TransForm_Data:images[2]] suncess:^(id suncess) {
        NSLog(@"");;
        [self backAction];
    } failure:^(id error) {
        
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (IXMSDKScreenWith/3-30)+44+66;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
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


-(NSData *)Image_TransForm_Data:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image , 0.5);
    //几乎是按0.5图片大小就降到原来的一半 比如这里 24KB 降到11KB
    return imageData;
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
@end
