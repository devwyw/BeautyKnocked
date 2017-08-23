//
//  Acount.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "Acount.h"
#import <FMDB.h>
#import "LoginController.h"

static Acount *instance=nil;

@interface Acount ()<NSCopying,NSMutableCopying>{
    FMDatabase *Data;
}

@end

@implementation Acount
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
+(instancetype)shareManager{
    if (!instance) {
        instance = [[Acount alloc]init];
        [instance initDataBase];
    }
    return instance;
}
#pragma mark ===== 账号接口 =====
-(void)initDataBase{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"acount.sqlite"];
    Data = [FMDatabase databaseWithPath:filePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [self GetAcount];
    }else{
        [Data open];
        [Data executeUpdate:@"CREATE TABLE 'acount' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'aid' VARCHAR(255),'account' VARCHAR(255),'nickName' VARCHAR(255),'headPath' VARCHAR(255),'rank' VARCHAR(255),'money' VARCHAR(255),'score' VARCHAR(255),'longitude' VARCHAR(255),'latitude' VARCHAR(255),'token' VARCHAR(255))"];
        [Data close];
    }
}
/** 账号登录 */
-(void)SignInAcount{
    [Data open];
    FMResultSet *res = [Data executeQuery:@"SELECT * FROM acount"];
    NSString *aid=[[NSString alloc]init];
    while ([res next]) {
        aid=[res stringForColumn:@"aid"];
    }
    if (!isStringEmpty(aid)) {
        [Data executeUpdate:@"DELETE FROM acount WHERE aid = ?",aid];
    }
    [Data executeUpdate:@"INSERT INTO acount(aid,account,nickName,headPath,rank,money,score,longitude,latitude,token) VALUES(?,?,?,?,?,?,?,?,?,?)",self.id,self.account,self.nickName,self.headPath,self.rank,self.money,self.score,self.longitude,self.latitude,self.token];
    [Data close];
}
/** 账号退出 */
-(void)SignOutAcount{
    [Data open];
    [Data executeUpdate:@"DELETE FROM acount WHERE aid = ?",self.id];
    [Data close];
    {
        NSDictionary *userDict=self.mj_keyValues;
        for (NSString *key in [userDict allKeys]) {
            [userDict setValue:@"" forKey:key];
        }
        instance=[Acount mj_objectWithKeyValues:userDict];
    }
}
/** 账号修改 */
-(void)UpdateAcount{
    [Data open];
    [Data executeUpdate:@"UPDATE 'acount' SET account = ?  WHERE aid = ? ",self.account,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET nickName = ?  WHERE aid = ? ",self.nickName,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET headPath = ?  WHERE aid = ? ",self.headPath,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET rank = ?  WHERE aid = ? ",self.rank,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET money = ?  WHERE aid = ? ",self.money,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET score = ?  WHERE aid = ? ",self.score,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET longitude = ?  WHERE aid = ? ",self.longitude,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET latitude = ?  WHERE aid = ? ",self.latitude,self.id];
    [Data executeUpdate:@"UPDATE 'acount' SET token = ?  WHERE aid = ? ",self.token,self.id];
    [Data close];
}
/** 获取账号信息 */
-(void)GetAcount{
    [Data open];
    FMResultSet *res = [Data executeQuery:@"SELECT * FROM acount"];
    while ([res next]) {
        self.id=[res stringForColumn:@"aid"];
        self.account=[res stringForColumn:@"account"];
        self.nickName=[res stringForColumn:@"nickName"];
        self.headPath=[res stringForColumn:@"headPath"];
        self.rank=[res stringForColumn:@"rank"];
        self.money=[res stringForColumn:@"money"];
        self.score=[res stringForColumn:@"score"];
        self.longitude=[res stringForColumn:@"longitude"];
        self.latitude=[res stringForColumn:@"latitude"];
        self.token=[res stringForColumn:@"token"];
    }
    [Data close];
}
/** 账号是否登录 */
-(BOOL)isSignInWithNavigationController:(UINavigationController*)navigationController{
    if (!isStringEmpty(self.id)) {
        return YES;
    }else{
        LoginController *loginController = [[LoginController alloc] init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginController];
        [navigationController presentViewController:loginNav animated:YES completion:nil];
        return NO;
    }
}
@end
