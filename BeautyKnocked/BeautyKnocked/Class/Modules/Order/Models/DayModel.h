//
//  DayModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayModel : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;
-(instancetype)initGetHttpData:(NSString*)time;
@end
