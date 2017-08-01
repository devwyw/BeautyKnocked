//
//  AdminManager.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Acount;
@class User;

@interface AdminManager : NSObject
/** 单例模式 */
+(instancetype)shareManager;
/** 检测网络 */
+(void)getNetWork:(id)Weakself;
#pragma mark ===== 接口 =====
/** 账号组 */

/**  在线用户 */


@end
