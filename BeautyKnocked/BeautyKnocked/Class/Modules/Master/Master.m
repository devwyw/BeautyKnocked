//
//  Master.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "Master.h"
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <LEEAlert.h>
#import "RegisterController.h"
#import "LoginController.h"

@interface Master ()
@end

@implementation Master
#pragma mark ===== 检测网络 =====
+(void)getNetWork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
            {
                [LEEAlert alert].config
                .LeeTitle(@"网络未连接")
                .LeeContent(@"我们未在地球上找到您的连接")
                .LeeCancelAction(@"网络设置", ^{
                    [Master pushSystemSettingWithUrl:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];
                })
                .LeeAction(@"确定", ^{
                })
                .LeeShow();
            }
                break;
            default:
                NSLog(@"网络正常");
                break;
        }
    }];
    [manager startMonitoring];
}
+(void)pushSystemSettingWithUrl:(NSString *)url{
    NSURL *SettingUrl=[NSURL URLWithString:url];
    if ([[UIApplication sharedApplication] canOpenURL:SettingUrl]) {
        if (SystemVersion>=10.0) {
            [[UIApplication sharedApplication] openURL:SettingUrl options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:SettingUrl];
        }
    }
}
#pragma mark ===== 所有网络请求 =====
+(NSString *)gettTimes{
    //时间戳
    NSDate * senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [dateformatter stringFromDate:senddate];
    return timeString;
}
+(NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    //加密规则
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(NSString *)get32bitString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
/**
 @param params 请求参数
 @param url 公共链接头
 @param serviceCode 当前请求片段
 @param success 成功回调
 @param failure 失败回调
 */
+(void)HttpPostRequestByParams:(NSDictionary *)params url:(NSString *)url serviceCode:(NSString *)serviceCode Success:(HttpSuccessBlock)success Failure:(HttpFalureBlock)failure andNavigation:(UINavigationController *)navigationController{
    /** 状态栏小菊花 */
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    /** 拼接 */
    url = [NSString stringWithFormat:@"%@%@",url,serviceCode];
    {/** 菊花 */
        [SVProgressHUD show];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setMinimumDismissTimeInterval:3];
    }
    /** Post网络请求 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [SVProgressHUD dismiss];
        
        NSData *data = responseObject;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers  error:nil];
        NSLog(@"%@",resultDic);
        if (!isObjectEmpty(success)) {
            if ([Master getSuccess:resultDic WithUINavigationController:navigationController]) {
                success(resultDic);
            }
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [SVProgressHUD dismiss];
        
        NSLog(@"json错误: %@",error);
        switch (error.code) {
            case -1004:
                [Master showSVProgressHUD:@"我们未能与您连接，请您再试一试~" withType:ShowSVProgressTypeError withShowBlock:nil];
                break;
            default:
                [LEEAlert alert].config
                .LeeTitle(@"网络未连接")
                .LeeContent(@"我们未在地球上找到您的连接")
                .LeeCancelAction(@"网络设置", ^{
                    [Master pushSystemSettingWithUrl:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];
                })
                .LeeAction(@"确定", ^{
                })
                .LeeShow();
                break;
        }
        if (!isObjectEmpty(failure)){
            failure(error);
        }
    }];
}
+(void)GetWebImage:(UIImageView*)imageView withUrl:(NSString*)Url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mlqqm,Url]] placeholderImage:[UIImage imageNamed:@"touxiang_03"]];
}
#pragma mark ===== Other =====
-(void)getSub:(UIView *)view andLevel:(int)level{
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"%@", blank];
        }
        NSLog(@"%@%d: %@", blank, level, subview.class);
        [self getSub:subview andLevel:(level+1)];
    }
}
+(void)showSVProgressHUD:(NSString*)string withType:(ShowSVProgressType)type withShowBlock:(ShowSVProgressBlock)block{
    switch (type) {
        case ShowSVProgressTypeInfo:
            [SVProgressHUD showInfoWithStatus:string];
            break;
        case ShowSVProgressTypeSuccess:
            [SVProgressHUD showSuccessWithStatus:string];
            break;
        case ShowSVProgressTypeError:
            [SVProgressHUD showErrorWithStatus:string];
            break;
        default:
            [SVProgressHUD show];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            break;
    }
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:1.6 completion:^{
        if (!isObjectEmpty(block)) {
            block();
        }
    }];
}
+(BOOL)getSuccess:(id)json WithUINavigationController:(UINavigationController*)root{
    switch ([json[@"status"] integerValue]) {
        case 200:
            return YES;
            case 7:
        {
            [Master showSVProgressHUD:json[@"message"] withType:ShowSVProgressTypeError withShowBlock:^{
                RegisterController *controller=[[RegisterController alloc]init];
                controller.isType=NO;
                controller.isLock=YES;
                if (!isObjectEmpty(root)) {
                    [root pushViewController:controller animated:YES];
                }
            }];
            return NO;
        }
            case 8:
        {
            [Master showSVProgressHUD:json[@"message"] withType:ShowSVProgressTypeError withShowBlock:^{
                LoginController *loginController = [[LoginController alloc] init];
                UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginController];
                if (!isObjectEmpty(root)) {
                    [root presentViewController:loginNav animated:YES completion:^{
                        [root popToRootViewControllerAnimated:NO];
                    }];
                }
            }];
            return NO;
        }
        default:
            [Master showSVProgressHUD:json[@"message"] withType:ShowSVProgressTypeError withShowBlock:nil];
            return NO;
    }
}
@end
