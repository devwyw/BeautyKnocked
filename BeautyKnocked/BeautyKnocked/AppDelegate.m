//
//  AppDelegate.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[NSThread sleepForTimeInterval:3.0];//设置启动页面时间
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TabBarController alloc] init];
    [self.window makeKeyAndVisible];
    [self setupGlobalAppearance];
    
    /** 配置区 */
    [self getLog];
    

    return YES;
}

-(void)setupGlobalAppearance{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
     [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"fanhui2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    [navigationBarAppearance setTranslucent:YES];
    [navigationBarAppearance setBackgroundImage:[UIImage GetImageWithColor:[UIColor colorWithHexString:@"#E1BF6E"] andAlpha:1 andHeight:64] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
}
#pragma mark ===== NSLog =====
-(void)getLog{
    NSLog(@"%.2f",SystemVersion);
}
#pragma mark ===== App管理 =====
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [AdminManager getNetWork:self.window.rootViewController];
}
- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
