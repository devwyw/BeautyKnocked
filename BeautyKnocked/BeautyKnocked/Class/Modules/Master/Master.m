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
#import "TabBarController.h"
/** 获取IP */
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

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
        NSString *blank;
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
    [SVProgressHUD dismissWithDelay:1.66 completion:^{
        if (!isObjectEmpty(block)) {
            block();
        }
    }];
}
+(BOOL)getSuccess:(id)json WithUINavigationController:(UINavigationController*)root{
    switch ([json[@"status"] integerValue]) {
        case 200:
            return YES;
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
+(void)setTabBarItem:(NSInteger)item withNavigationController:(UINavigationController*)navigationController{
    UITabBarController *controller=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    controller.selectedIndex=item;
    [navigationController popToRootViewControllerAnimated:NO];
}
#pragma mark ===== 获取ipv4 =====
+(NSString *)getIPv4{
    NSArray *searchArray = @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ];
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+(BOOL)isValidatIP:(NSString *)ipAddress{
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch)return YES;
    }
    return NO;
}
+(NSDictionary *)getIPAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)) {
                continue;
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
@end
