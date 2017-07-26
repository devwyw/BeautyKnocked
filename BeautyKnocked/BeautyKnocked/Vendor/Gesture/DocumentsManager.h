//
//  DocumentsManager.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsManager : NSObject
/** 单例模式 */
+(instancetype)shareManager;
/** 颜色转图片 */
+(UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
/** 获取搜索栏数据 */
+(NSMutableArray*)getSearchArray;
/** 保存搜索栏数据 */
+(BOOL)saveSearchArray:(NSMutableArray*)array;
/** 打印所有子视图 */
+(void)getSub:(UIView *)view andLevel:(int)level;
@end
