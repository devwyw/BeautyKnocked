//
//  AppDelegate+Alipay.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate+Alipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (Alipay)
+(void)AliPayWithPayOrder:(NSString*)order{
    [[AlipaySDK defaultService]payOrder:order fromScheme:@"BeautyKnocked" callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            [AppDelegate Success];
        }else{
            [AppDelegate Failure];
        }
    }];
}
+(void)openURL:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [AppDelegate Success];
            }else{
                [AppDelegate Failure];
            }
        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *result = resultDic[@"result"];
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        NSLog(@"授权结果:%@",[subResult substringFromIndex:10]);
                        break;
                    }
                }
            }
            
        }];
    }
}
+(void)openURLWithOptions:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [AppDelegate Success];
            }else{
                [AppDelegate Failure];
            }
        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *result = resultDic[@"result"];
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        NSLog(@"授权结果:%@",[subResult substringFromIndex:10]);
                        break;
                    }
                }
            }
        }];
    }
}
@end
