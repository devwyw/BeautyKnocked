//
//  AppDelegate+UShare.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate+UShare.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@implementation AppDelegate (UShare)

+(void)registerShareKey{
    UMSocialManager *manager=[UMSocialManager defaultManager];
    [manager openLog:YES];
    [manager setUmSocialAppkey:@"59bc7b7475ca3573aa000034"];
    /** 注册分享平台Appkey */
    [manager setPlaform:UMSocialPlatformType_QQ appKey:@"1105862534" appSecret:nil redirectURL:nil];
    [manager setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx1dba3ac93eb4b2e5" appSecret:@"a87e247df22c946284afc22b4121be18" redirectURL:nil];
    [manager setPlaform:UMSocialPlatformType_Sina appKey:@"911941824" appSecret:@"513ad4702b0fb538bc581b03d03598c3" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}
+(BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}
+(void)popShareSheetViewWithMessage:(NSString*)message{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        switch (platformType) {
            case UMSocialPlatformType_WechatSession:
                [AppDelegate shareWechatSessionWithMessage:message];
                break;
            case UMSocialPlatformType_WechatTimeLine:
                [AppDelegate shareWechatTimeLineWithMessage:message];
                break;
            case UMSocialPlatformType_QQ:
                [AppDelegate shareQQWithMessage:message];
                break;
            case UMSocialPlatformType_Sina:
                [AppDelegate shareSinaWithMessage:message];
                break;
            default:
                break;
        }
    }];
}
+(void)shareWechatSessionWithMessage:(NSString*)message{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [messageObject setText:message];
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];
}
+(void)shareWechatTimeLineWithMessage:(NSString*)message{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [messageObject setText:message];
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];
}
+(void)shareQQWithMessage:(NSString*)message{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [messageObject setText:message];
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];}
+(void)shareSinaWithMessage:(NSString*)message{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [messageObject setText:message];
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];
}
+(void)shareSmsWithPhoneNumber:(NSString*)phone andMessage:(NSString*)message{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareSmsObject *sms=[[UMShareSmsObject alloc]init];
    [sms setRecipients:[phone componentsSeparatedByString:@","]];
    [sms setSmsContent:message];
    messageObject.shareObject=sms;
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sms messageObject:messageObject currentViewController:[UIApplication sharedApplication].keyWindow.rootViewController completion:nil];}
@end
