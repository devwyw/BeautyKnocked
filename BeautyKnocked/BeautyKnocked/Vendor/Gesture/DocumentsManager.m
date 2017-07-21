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
    [instance setString:@"123"];
}
+(instancetype)alloc{
    if (instance) {
        NSException *exp=[[NSException alloc]initWithName:@"SQLiteManager单例警告" reason:@"只能有一个实例" userInfo:nil];
        [exp raise];
    }
    return [super alloc];
}
+(instancetype)shareManager{
    return instance;
}
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
@end
