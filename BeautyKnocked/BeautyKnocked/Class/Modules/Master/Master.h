//
//  Master.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ShowSVProgressTypeInfo,
    ShowSVProgressTypeSuccess,
    ShowSVProgressTypeError
} ShowSVProgressType;

typedef void(^HttpSuccessBlock)(id json);
typedef void(^HttpFalureBlock)(NSError *error);
typedef void(^ShowSVProgressBlock)();
typedef void(^PopViewBlock)();
typedef void(^PopViewHideBlock)();

@interface Master : NSObject
/** 选择TabBarItem */
+(void)setTabBarItem:(NSInteger)item withNavigationController:(UINavigationController*)navigationController;
/** 检测网络 */
+(void)getNetWork;
/** 跳转到设置 */
+(void)pushSystemSettingWithUrl:(NSString *)url;
/** 提示框 */
+(void)showSVProgressHUD:(NSString*)string withType:(ShowSVProgressType)type withShowBlock:(ShowSVProgressBlock)block;
#pragma mark ===== 所有网络请求 =====
/** 微信支付签名 */
+(NSString *)getSign:(NSDictionary *)signParams;
/** 时间戳 */
+(NSString *)gettTimes;
/** MD5加密 */
+(NSString *)md5:(NSString *)string;
/** 32位随机数 */
+(NSString *)get32bitString;
/** Post请求 */
+(void)HttpPostRequestByParams:(NSDictionary *)params url:(NSString *)url serviceCode:(NSString *)serviceCode Success:(HttpSuccessBlock)success Failure:(HttpFalureBlock)failure
                 andNavigation:(UINavigationController*)navigationController;
/** 网络图片 */
+(void)GetWebImage:(UIImageView*)imageView withUrl:(NSString*)Url;
/** 获取ip */
+(NSString *)getIPv4;
/** 弹出SheetView */
+(void)PopSheetView:(UIView*)view;
/** 弹出AlertView */
+(void)PopAlertView:(UIView*)view WithTitle:(NSString*)title WithDoneBlock:(PopViewBlock)block;
/** 弹出AlertEditView */
+(void)PopAlertView:(UIView*)view;
/** 关闭PopVIew */
+(void)RemovePopViewWithBlock:(PopViewHideBlock)block;
@end
