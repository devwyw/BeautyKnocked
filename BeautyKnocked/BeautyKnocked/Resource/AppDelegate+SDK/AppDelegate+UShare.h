//
//  AppDelegate+UShare.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UShare)
+(void)registerShareKey;
+(BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+(void)popShareSheetViewWithMessage:(NSString*)message;
/** 分享平台 */
+(void)shareWechatSessionWithMessage:(NSString*)message;
+(void)shareWechatTimeLineWithMessage:(NSString*)message;
+(void)shareQQWithMessage:(NSString*)message;
+(void)shareSinaWithMessage:(NSString*)message;
+(void)shareSmsWithPhoneNumber:(NSString*)phone andMessage:(NSString*)message;
@end
