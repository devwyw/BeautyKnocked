//
//  AppDelegate+JPush.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import <JPUSHService.h>
/** iOS10注册APNs所需头文件 */
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (JPush)
+(void)registerJPushSDKWithOptions:(NSDictionary *)launchOptions andDelegate:(id)appDelegate;
+(void)registerDeviceToken:(NSData *)deviceToken;
+(void)willPresentNotification:(UNNotification *)notification;
+(void)didReceiveNotificationResponse:(UNNotificationResponse *)response;
+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
+(void)removeAllPendingNotificationRequests;
@end
