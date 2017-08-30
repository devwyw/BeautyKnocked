//
//  AppDelegate+Alipay.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AppDelegate.h"
#define AlipaySuccess @"AlipaySuccess"
#define AlipayFailure @"AlipayFailure"

@interface AppDelegate (Alipay)
+(void)openURL:(NSURL *)url;
+(void)openURLWithOptions:(NSURL *)url;
+(void)AliPayWhitPayOrder:(NSString*)order;
@end
