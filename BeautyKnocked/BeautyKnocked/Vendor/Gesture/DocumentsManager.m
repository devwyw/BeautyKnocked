//
//  DocumentsManager.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "DocumentsManager.h"

static DocumentsManager *instance=nil;

@implementation DocumentsManager

+(void)load{
    /** 每次加载第一个调用的方法 */
    [super load];
    instance=[DocumentsManager new];
}
+(instancetype)alloc{
    if (instance) {
        NSException *exp=[[NSException alloc]initWithName:@"单例模式警告" reason:@"只能有一个实例" userInfo:nil];
        [exp raise];
    }
    return [super alloc];
}
+(instancetype)shareManager{
    return instance;
}
/** 颜色转图片 */
+(UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
/** 获取搜索栏数据 */
+(NSMutableArray*)getSearchArray{
    NSString *DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"searchlist.plist"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithContentsOfFile:filePath];

    if(!array){
        NSString *sysPath=[[NSBundle mainBundle]pathForResource:@"searchlist" ofType:@"plist"];
        array =[[NSMutableArray alloc]initWithContentsOfFile:sysPath];
        [array writeToFile:filePath atomically:YES];
    }
    return array;
}
/** 保存搜索栏数据 */
+(BOOL)saveSearchArray:(NSMutableArray*)array{
    if (array) {
        NSString *DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"searchlist.plist"];
        [array writeToFile:filePath atomically:YES];
        return YES;
    }else{
        return NO;
    }
}
@end
