//
//  AdminManager.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AdminManager.h"
#import <FMDB.h>
#import "Acount.h"
#import "User.h"

static AdminManager *instance=nil;

@interface AdminManager ()<NSCopying,NSMutableCopying>{
    FMDatabase *Data;
}
@end

@implementation AdminManager
#pragma mark ===== 单例模式 =====
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}
-(id)copy{
    return self;
}
-(id)mutableCopy{
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}
-(void)initDataBase{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    Data = [FMDatabase databaseWithPath:filePath];
    [Data open];

    NSString *acount = @"CREATE TABLE 'acount' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'acount' VARCHAR(255),'name' VARCHAR(255))";
    
    NSString *user = @"CREATE TABLE 'user' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'phone' VARCHAR(255),'password' VARCHAR(255)) ";
    
    [Data executeUpdate:acount];
    [Data executeUpdate:user];
    
    [Data close];
}
+(instancetype)shareManager{
    if (!instance) {
        instance = [[AdminManager alloc]init];
        [instance initDataBase];
    }
    return instance;
}
#pragma mark ===== 数据库接口 =====




#pragma mark ===== 检测网络 =====
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
 #pragma mark ===== 打印所有子视图 =====
-(void)getSub:(UIView *)view andLevel:(int)level{
    NSArray *subviews = [view subviews];
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"%@", blank];
        }
        NSLog(@"%@%d: %@", blank, level, subview.class);
        [self getSub:subview andLevel:(level+1)];
    }
}
@end
