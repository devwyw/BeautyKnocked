//
//  AppDelegate+Alipay.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#define AlipaySuccess @"AlipaySuccess"
#define AlipayFailure @"AlipayFailure"

@interface AppDelegate (Alipay)
+(void)openURL:(NSURL *)url;
+(void)openURLWithOptions:(NSURL *)url;
+(void)Success;
+(void)Failure;
@end
