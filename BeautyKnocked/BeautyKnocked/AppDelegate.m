//
//  AppDelegate.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import <IQKeyboardManager.h>
#import "AppDelegate+JPush.h"
#import "AppDelegate+Alipay.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[NSThread sleepForTimeInterval:3.0];
    /** RootViewController */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
    /** 配置区 */
    [self setAppearance];
    [self getLog];
    
    /** 极光推送->注册 */
    [AppDelegate registerJPushSDKWithOptions:launchOptions delegate:self];

    return YES;
}
-(void)setAppearance{
    /** IQ键盘配置 */
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    /** 导航栏返回按钮图片 */
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-Width, -Height) forBarMetrics:UIBarMetricsDefault];
     [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"fanhui2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    /** 导航栏背景配置 */
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    [navigationBarAppearance setTranslucent:YES];
    [navigationBarAppearance setBackgroundImage:[AppDelegate GetImageWithColor:ThemeColor andAlpha:1 andHeight:64] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
}
/** Color->Image */
+(UIImage*)GetImageWithColor:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color colorWithAlphaComponent:alpha].CGColor);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
#pragma mark ===== NSLog =====
-(void)getLog{
    NSLog(@"\n系统:%.2f\n版本:%@\nUUID:%@\n账号:%@",
          SystemVersion,
          AppVersion,
          UUID,
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
    /** 支付宝 */
    [AppDelegate openURL:url];
    return YES;
}
// 9.0以后新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    /** 支付宝 */
    [AppDelegate openURLWithOptions:url];
    return YES;
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
