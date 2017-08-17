//
//  Acount.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acount : NSObject
#pragma mark ===== 单例模式 =====
+(instancetype)shareManager;
#pragma mark ===== 用户模型 =====
/** 客户id */
@property (nonatomic,copy) NSString * id;
/** 账号 */
@property (nonatomic,copy) NSString * account;
/** #昵称# */
@property (nonatomic,copy) NSString * nickName;
/** #头像路径# */
@property (nonatomic,copy) NSString * headPath;
/** #Vip等级# */
@property (nonatomic,copy) NSString * rank;
/** #余额# */
@property (nonatomic,copy) NSString * money;
/** #积分# */
@property (nonatomic,copy) NSString * score;
/** #经度# */
@property (nonatomic,copy) NSString * longitude;
/** #纬度# */
@property (nonatomic,copy) NSString * latitude;
/** token标识符 */
@property (nonatomic,copy) NSString * token;
#pragma mark ===== 账号接口 =====
/** 账号登录 */
-(void)SignInAcount;
/** 账号退出 */
-(void)SignOutAcount;
/** 账号修改 */
-(void)UpdateAcount;
/** 获取账号信息 */
-(void)GetAcount;
/** 账号是否登录 */
-(BOOL)isSignIn;
@end
