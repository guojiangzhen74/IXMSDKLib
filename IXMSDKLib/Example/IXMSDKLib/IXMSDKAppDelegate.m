//
//  IXMSDKAppDelegate.m
//  IXMSDKLib
//
//  Created by 郭江震 on 09/22/2017.
//  Copyright (c) 2017 郭江震. All rights reserved.
//

#import "IXMSDKAppDelegate.h"
#import "SVProgressHUD.h"
#import "ViewController.h"
#import "IXMConfig.h"

@implementation IXMSDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    
    ViewController *vc=[ViewController new];
    
    vc.title=@"IXMSDK调用DEMO";
    
    UINavigationController *Nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController =Nav;
    
    
    [[IXMConfig globalConfig] setIXMSDKAUTHKEY:@"GrFmeaBQap5ESETu"];
    [[IXMConfig globalConfig] setIXMSDKXMGOV_API_SourceID:@"2"];
    [[IXMConfig globalConfig] setIXMSDKnavBackgroundColor:[UIColor colorWithRed:242/255.0 green:156/255.0 blue:177/255.0 alpha:1]];
    [self setSVProgressHUD];
    
    
    return YES;
}
/**
 *	设置提示框样式
 */
-(void)setSVProgressHUD{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setRingThickness:2];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
