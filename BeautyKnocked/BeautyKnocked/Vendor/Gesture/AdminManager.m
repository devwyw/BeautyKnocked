//
//  AdminManager.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AdminManager.h"

static AdminManager *instance=nil;

@implementation AdminManager

+(void)load{
    /** 每次加载第一个调用的方法 */
    [super load];
    instance=[AdminManager new];
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
/** 打印所有子视图 */
+(void)getSub:(UIView *)view andLevel:(int)level{
    NSArray *subviews = [view subviews];
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        // 打印子视图类名
        NSLog(@"%@%d: %@", blank, level, subview.class);
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
    }
}
@end
