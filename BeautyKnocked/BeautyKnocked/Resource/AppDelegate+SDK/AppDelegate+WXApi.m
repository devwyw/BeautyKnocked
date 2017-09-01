//
//  AppDelegate+WXApi.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate+WXApi.h"

static NSString *AppKey = @"wx1dba3ac93eb4b2e5";
@implementation AppDelegate (WXApi)

+(void)registerWAppKey{
    [WXApi registerApp:AppKey];
}
+(BOOL)handleOpenURL:(NSURL*)url Delegate:(id)delegate{
    return [WXApi handleOpenURL:url delegate:delegate];
}
+(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                [AppDelegate Success];
                break;
            default:
                [AppDelegate Failure];
                break;
        }
    }
}
+(void)WXPayWithPrepayId:(NSString*)prepayId{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"1412655502";
    request.prepayId= prepayId;
    request.package = @"Sign=WXPay";
    request.nonceStr= [Master get32bitString];
    request.timeStamp=[[Master gettTimes] intValue];

    NSDictionary *dic = @{@"partnerid" : request.partnerId,
                          @"prepayid" : request.prepayId,
                          @"package" : request.package,
                          @"noncestr" : request.nonceStr,
                          @"timestamp" : [NSString stringWithFormat:@"%d",request.timeStamp],
                          @"appid" : @"wx1dba3ac93eb4b2e5"};
    request.sign= [Master getSign:dic];
    [WXApi sendReq:request];
}
@end
