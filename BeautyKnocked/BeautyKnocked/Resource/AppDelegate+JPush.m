//
//  AppDelegate+JPush.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate+JPush.h"

static NSString *JPushKey = @"1481b2a73612a63a7dd20bd3";

@implementation AppDelegate (JPush)
+(void)registerJPushSDKWithOptions:(NSDictionary *)launchOptions andDelegate:(id)appDelegate{
    if (SystemVersion >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:appDelegate];
    }else if (SystemVersion >= 8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPushKey
                          channel:@"App Store"
                 apsForProduction:1
     ];
}
@end
