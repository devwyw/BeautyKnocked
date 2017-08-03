//
//  MLDateManager.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MLDateManager.h"

@implementation MLDateManager

+(NSArray *)fetchDate {
    
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:42];//****
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *todayDate = [NSDate date];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    //today
    NSDateComponents *todayComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    NSInteger todayWeekDay = todayComponents.weekday;
    
    // add before today
    for (NSInteger i = 1; i < todayWeekDay; i += 1) {
        
        NSDate *date = [todayDate dateByAddingTimeInterval: - i*3600*24];
        
        NSDateComponents *components = [calendar components:calendarUnit fromDate:date];
        
        MLDateModel *dateModel = [[MLDateModel alloc] initWithComponents:components];
        dateModel.isInThirtyDays = NO;
        [dataSource insertObject:dateModel atIndex:0];
        
    }
    
    // add today
    MLDateModel *todayDateModel = [[MLDateModel alloc] initWithComponents:todayComponents];
    todayDateModel.isInThirtyDays = YES;
    [dataSource addObject:todayDateModel];
    // add after today
    for (NSInteger i = 1; i <= 42 - todayWeekDay; i += 1) {
        NSDate *date = [todayDate dateByAddingTimeInterval:i*3600*24];
        
        NSDateComponents *components = [calendar components:calendarUnit fromDate:date];
        
        MLDateModel *dateModel = [[MLDateModel alloc] initWithComponents:components];
        dateModel.isInThirtyDays = i <= 30 ? YES:NO;
        [dataSource addObject:dateModel];
    }
    
    return dataSource;
}

+(NSArray *)fetchOneDayTime {
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:48];
    
    for (NSInteger i = 0; i < 24; i += 1) {
        NSString *ontime = [NSString stringWithFormat:@"%ld:00",(long)i];
        NSString *halftime = [NSString stringWithFormat:@"%ld:30",(long)i];
        [dataSource addObject:ontime];
        [dataSource addObject:halftime];
    }
    
    return dataSource;
}

@end
