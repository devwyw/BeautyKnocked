//
//  AppDelegate+WXApi.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import <WXApi.h>

@interface AppDelegate (WXApi)
+(void)registerWxAppKey;
+(BOOL)handleOpenURL:(NSURL*)url Delegate:(id)delegate;
+(void)onResp:(BaseResp*)resp;
+(void)WXPayWithPrepayId:(NSString*)prepayId;
@end
