//
//  Master.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Acount;

@interface Master : NSObject
/** 单例模式 */
+(instancetype)shareManager;
/** 检测网络 */
+(void)getNetWork:(id)Weakself;

#pragma mark ===== 账号接口 =====
/** 增加账号 */
-(void)addAcount:(Acount*)acount;
/** 删除账号 */
-(void)deleteAcount:(Acount*)acount;
/** 修改账号 */
-(void)updateAcount:(Acount*)acount;
/** 查询账号 */
-(NSMutableArray*)getAllAcount;
@end
