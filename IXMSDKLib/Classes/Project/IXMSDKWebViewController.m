//
//  IXMWebViewController.m
//  SDKTEST
//
//  Created by 严贵敏 on 2017/4/27.
//  Copyright © 2017年 严贵敏. All rights reserved.
//

#import "IXMSDKWebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "IXMConfig.h"
#import "IXMSDKConfing.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface IXMSDKWebViewController ()<WKNavigationDelegate,WKUIDelegate>{
    
    WKWebView *ixWebView;
    IXMConfig *ixmconfig;

    
}
@end

@implementation IXMSDKWebViewController

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
    titleLable.text=@"实名认证";
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
    
    
    //配置信息
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    config.preferences=[[WKPreferences alloc]init];
    config.preferences.javaScriptEnabled = true;
    // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
    config.preferences.javaScriptCanOpenWindowsAutomatically =true;
    config.userContentController=[[WKUserContentController alloc]init];
    config.allowsInlineMediaPlayback = YES;
    //    config.requiresUserActionForMediaPlayback = NO;
    
    
    

    ixWebView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, IXMSDKScreenWith, IXMSDKScreenHeight-64) configuration:config];
    
    
 
    
    //    ixWebView.configuration =config;
    //    ixWebView.opaque = NO;
    
    [ixWebView setMultipleTouchEnabled:YES];
    [ixWebView setAutoresizesSubviews:YES];
    [ixWebView.scrollView setAlwaysBounceVertical:YES];
    // 这行代码可以是侧滑返回webView的上一级，而不是跟控制器（*指针对侧滑有效）
    [ixWebView setAllowsBackForwardNavigationGestures:true];
    ixWebView.navigationDelegate =self;
    ixWebView.UIDelegate =self;
    ixWebView.backgroundColor = [UIColor clearColor];
    ixWebView.scrollView.showsHorizontalScrollIndicator = NO;
    ixWebView.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:ixWebView];
    
    [self refreshData];

}


-(void)backAction{
    
    switch (self.type) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        case 1:
            if (_isRegister) {
                [[self navigationController] popToRootViewControllerAnimated:YES];

            }else{
                [[self navigationController] popViewControllerAnimated:YES];
            }
            break;
            
            
        default:
            break;
    }
}


#pragma mark- 集成刷新控件
-(void)refreshData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    
    if (self.webUrl != nil) {
        
        NSURL *webViewUrl=[NSURL URLWithString:self.webUrl];
        NSURLRequest *webRequst=[[NSURLRequest alloc]initWithURL:webViewUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
        
        [ixWebView loadRequest:webRequst];
        
    }
}

/**
 *  刷新成功 结束刷新控件
 *
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    [SVProgressHUD dismiss];
 
    
}
/**
 *  刷新失败 结束刷新控件
 *
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    //    [SVProgressHUD showErrorWithStatus:@"请求超时,请重试!"];
    [SVProgressHUD dismiss];
    
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}



- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
}

@end
