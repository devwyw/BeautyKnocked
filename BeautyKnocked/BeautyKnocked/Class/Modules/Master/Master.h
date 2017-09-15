//
//  Master.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 服务器接口->简写拼音 */
#define zc @"/manager/client/base/registerManager/register"
#define zcyzm @"/manager/client/base/smsVerificationManager/sendVerification"
#define ptyzm @"/manager/client/base/smsVerificationManager/sendCode"
#define dl @"/manager/client/base/loginManager/login"
#define tcdl @"/manager/client/base/loginManager/outLongin"
#define wjmm @"/manager/client/base/loginManager/forgetPassword"
#define lbt @"/manager/client/base/bannerManager/queryList"
#define ghtx @"/manager/client/base/clientManager/updateHeadPath"
#define ggnc @"/manager/client/base/clientManager/updateNickName"
#define ggmm @"/manager/client/base/clientManager/updatePassword"
#define xmlb @"/manager/client/goods/projectManager/queryList"
#define xmlbpx @"/manager/client/goods/projectManager/queryListSort"
#define bqlb @"/manager/client/goods/labelManager/queryList"
#define xmxq @"/manager/client/goods/projectManager/queryDetail"
#define pllb @"/manager/client/goods/commentManager/queryListByCommId"
#define tjddpl @"/manager/client/goods/commentManager/submitBillComment"
#define tjxmlb @"/manager/client/goods/recommendManager/queryRecommendProject"
#define tclb @"/manager/client/goods/packageManager/queryList"
#define tclbpx @"/manager/client/goods/packageManager/queryListSort"
#define tcxq @"/manager/client/goods/packageManager/queryDetail"
#define cplb @"/manager/client/goods/productManager/queryList"
#define cplbpx @"/manager/client/goods/productManager/queryListSort"
#define cpxq @"/manager/client/goods/productManager/queryDetail"
#define czlb @"/manager/client/recharge/rechargeManager/queryListNormal"
#define czdd @"/manager/client/bill/rechargeBill/insert"
#define khyhqlb @"/manager/client/personal/clientCouponManager/queryList"
#define xzfwdz @"/manager/client/base/serviceAddressManager/addAddress"
#define xgfwdz @"/manager/client/base/serviceAddressManager/updateAddress"
#define fwdzlb @"/manager/client/base/serviceAddressManager/queryList"
#define mrslb @"/manager/client/base/beauticianManager/queryList"
#define mrslbpx @"/manager/client/base/beauticianManager/queryListSort"
#define khsc @"/manager/client/base/clientCollectManager/addCollect"
#define mrsskb @"/manager/client/base/beauticianTimeManager/queryList"
#define yhqsx @"/manager/client/personal/clientCouponManager/clientCouponScreen"
#define mrsskbsx @"/manager/client/base/beauticianManager/queryListScreen"
#define xeczlb @"/manager/client/recharge/rechargeManager/queryListSmall"
#define tjxmdd @"/manager/client/bill/projectBillManager/addBill"
#define qrxmdd @"/manager/client/bill/projectBillManager/addYesBill"
#define scfwdz @"/manager/client/base/serviceAddressManager/deleteAddress"
#define mrssx @"/manager/client/base/beauticianManager/queryScreen"
#define tjtcdd @"/manager/client/bill/packagerBillManager/addBill"
#define tjcpdd @"/manager/client/bill/productBillManager/addBill"
#define pdxrq @"/manager/client/coupon/collarCouponManager/isNewCoupon"
#define czxq @"/manager/client/recharge/rechargeManager/queryDetail"
#define mhss @"/manager/client/goods/searchManager/queryLike"
#define tjmrs @"/manager/client/base/beauticianManager/recommend"
#define lxrq @"/manager/client/coupon/collarCouponManager/newCoupon"
#define gyxm @"/manager/client/goods/aboutManager/aboutProject"
#define mldt @"/manager/client/bill/projectBillManager/dynamic"
#define jflb @"/manager/client/goods/exchangeManager/queryList"
#define khjf @"/manager/client/base/clientManager/queryIntegral"
#define dhxq @"/manager/client/goods/exchangeManager/queryDetail"
#define dh @"/manager/client/bill/exchangeBillManager/exchange"
#define dhjl @"/manager/client/bill/exchangeBillManager/record"
#define sclb @"/manager/client/base/clientCollectManager/collectList"
#define qxsc @"/manager/client/base/clientCollectManager/deleteCollect"
#define ddlb @"/manager/client/bill/billManager/queryAllOrStatus"
#define xtxx @"/manager/client/base/newsManager/queryList"
#define wdxxs @"/manager/client/base/newsManager/queryUnreadNum"
#define yd @"/manager/client/base/newsManager/read"
#define gwclb @"/manager/client/goods/shoppingCartManager/queryList"
#define gwcplsc @"/manager/client/goods/shoppingCartManager/deleteList"
#define jrgwc @"/manager/client/goods/shoppingCartManager/add"
#define gwcsl @"/manager/client/goods/shoppingCartManager/updateNum"
#define yjrgwc @"/manager/client/goods/shoppingCartManager/isAdd"
#define yjfk @"/manager/client/base/feedbackManager/add"
#define gycp @"/manager/client/goods/aboutManager/aboutProduct"
#define gdyy @"/manager/client/base/lightManager/add"
#define yemx @"/manager/beautician/base/balanceDetailManager/queryList"
#define jd @"/manager/client/bill/projectBillManager/upBill"

/** 提示框风格 */
typedef enum : NSUInteger {
    ShowSVProgressTypeInfo,
    ShowSVProgressTypeSuccess,
    ShowSVProgressTypeError
} ShowSVProgressType;
/** 自定义代码块 */
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
/** Post请求->无加载动画 */
+(void)WebPostRequestByParams:(NSDictionary *)params url:(NSString *)url serviceCode:(NSString *)serviceCode Success:(HttpSuccessBlock)success Failure:(HttpFalureBlock)failure
                 andNavigation:(UINavigationController*)navigationController;
/** 加载菊花动画 */
+(void)startStatus;
+(void)stopStatus;
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
/** Line */
+(UIView*)getLineView:(UIColor*)color;
@end
