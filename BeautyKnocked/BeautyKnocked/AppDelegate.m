//
//  AppDelegate.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "StartImageController.h"
#import <IQKeyboardManager.h>
#import "AppDelegate+JPush.h"
#import "AppDelegate+Alipay.h"
#import "AppDelegate+WXApi.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[NSThread sleepForTimeInterval:3.0];
    /** RootViewController */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    /** 首次启动 */
    if (isStringEmpty([[NSUserDefaults standardUserDefaults] objectForKey:@"isStartUp"])) {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isStartUp"];
        self.window.rootViewController = [[StartImageController alloc]init];
    }else{
        self.window.rootViewController = [[TabBarController alloc]init];
    }
    [self.window makeKeyAndVisible];
    
    /** 配置区 */
    [self setAppearance];
    [self getLog];
    
    /** 极光推送->注册 */
    [AppDelegate registerJPushSDKWithOptions:launchOptions Delegate:self];
    /** 微信支付->注册 */
    [AppDelegate registerWAppKey];
    
    return YES;
}
-(void)setAppearance{
    /** IQ键盘配置 */
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    /** 导航栏返回按钮图片 */
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"fanhui2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    /** 全局标题配置 */
    UINavigationBar *navigation = [UINavigationBar appearance];
    [navigation setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    [navigation setTintColor:[UIColor clearColor]];
}
#pragma mark ===== NSLog =====
-(void)getLog{
    NSLog(@"\n系统:%.2f\n版本:%@\n账号:%@",
          SystemVersion,
          AppVersion,
          [Acount shareManager].account
          );
}
#pragma mark ===== JPush =====
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AppDelegate registerDeviceToken:deviceToken];
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    [AppDelegate willPresentNotification:notification];
    completionHandler(UNNotificationPresentationOptionAlert);
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [AppDelegate didReceiveNotificationResponse:response];
    completionHandler();
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (SystemVersion < 10.0){
        [AppDelegate didReceiveRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [AppDelegate didReceiveRemoteNotification:userInfo];
}
#pragma mark ===== 支付SDK =====
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        /** 支付宝 */
        [AppDelegate openURL:url];
        return YES;
    }else{
        /** 微信支付 */
        return [AppDelegate handleOpenURL:url Delegate:self];
    }
}
// 9.0以后新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        /** 支付宝 */
        [AppDelegate openURLWithOptions:url];
        return YES;
    }else{
        /** 微信支付 */
        return [AppDelegate handleOpenURL:url Delegate:self];
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AppDelegate handleOpenURL:url Delegate:self];
}
-(void)onResp:(BaseResp*)resp{
    [AppDelegate onResp:resp];
}
+(void)Success{
    [[NSNotificationCenter defaultCenter]postNotificationName:paySuccess object:nil];
}
+(void)Failure{
    [[NSNotificationCenter defaultCenter]postNotificationName:payFailure object:nil];
}
#pragma mark ===== App管理 =====
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [AppDelegate removeAllPendingNotificationRequests];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [AppDelegate removeAllPendingNotificationRequests];
    if (SystemVersion>=10.0) {
        [[UNUserNotificationCenter alloc] removeAllPendingNotificationRequests];
    }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [Master getNetWork];
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
@end
