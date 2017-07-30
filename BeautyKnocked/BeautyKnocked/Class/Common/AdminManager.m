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

+(void)getNetWork:(id)Weakself{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"未识别网络" message:@"您正在使用地球之外的网络." preferredStyle:UIAlertControllerStyleAlert];
                [alter addAction:[UIAlertAction actionWithTitle:@"网络设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [instance pushSystemSetting];
                }]];
                [alter addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
                [Weakself presentViewController:alter animated:YES completion:nil];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"网络未连接" message:@"我们未在地球上找到您的连接." preferredStyle:UIAlertControllerStyleAlert];
                [alter addAction:[UIAlertAction actionWithTitle:@"网络设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [instance pushSystemSetting];
                }]];
                [alter addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
                [Weakself presentViewController:alter animated:YES completion:nil];
            }
                break;
            default:
                NSLog(@"网络正常");
                break;
        }
    }];
    [manager startMonitoring];
}
-(void)pushSystemSetting{
    NSURL *Network=[NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];
    if ([[UIApplication sharedApplication] canOpenURL:Network]) {
        if (SystemVersion >= 10.0) {
            [[UIApplication sharedApplication] openURL:Network options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:Network];
        }
    }
}

//+(NSMutableArray*)getSearchArray{
//    NSString *DocumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"xx.plist"];
//    NSMutableArray *array=[[NSMutableArray alloc]initWithContentsOfFile:filePath];
//
//    if(!array){
//        NSString *sysPath=[[NSBundle mainBundle]pathForResource:@"searchlist" ofType:@"plist"];
//        array =[[NSMutableArray alloc]initWithContentsOfFile:sysPath];
//        [array writeToFile:filePath atomically:YES];
//    }
//    return array;
//}
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
