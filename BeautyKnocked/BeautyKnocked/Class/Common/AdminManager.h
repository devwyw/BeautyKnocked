//
//  AdminManager.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdminManager : NSObject
/** 单例模式 */
+(instancetype)shareManager;



/** 颜色转图片 */
+(UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
/** 打印所有子视图 */
+(void)getSub:(UIView *)view andLevel:(int)level;
@end
