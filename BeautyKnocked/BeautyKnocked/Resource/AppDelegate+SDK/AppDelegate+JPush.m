//
//  AppDelegate+JPush.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate+JPush.h"

static NSString *AppKey = @"1481b2a73612a63a7dd20bd3";
@implementation AppDelegate (JPush)

+(void)registerJPushSDKWithOptions:(NSDictionary *)launchOptions Delegate:(id)delegate{
#ifdef DEBUG
    [JPUSHService setDebugMode];
#else
    [JPUSHService setLogOFF];
#endif
    
    if (SystemVersion >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
    }else if (SystemVersion >= 8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions
                           appKey:AppKey
                          channel:@"App Store"
                 apsForProduction:1
     ];
}
+(void)willPresentNotification:(UNNotification *)notification{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
}
+(void)didReceiveNotificationResponse:(UNNotificationResponse *)response{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
}
+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
}
+(void)removeAllPendingNotificationRequests{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
+(void)registerDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
}
@end
