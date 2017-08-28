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

@interface Master : NSObject
/** 检测网络 */
+(void)getNetWork;
/** 提示框 */
+(void)showSVProgressHUD:(NSString*)string withType:(ShowSVProgressType)type withShowBlock:(ShowSVProgressBlock)block;
#pragma mark ===== 所有网络请求 =====
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
@end
