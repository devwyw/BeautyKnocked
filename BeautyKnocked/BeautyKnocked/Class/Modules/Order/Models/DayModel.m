//
//  DayModel.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "DayModel.h"

@implementation DayModel

- (instancetype)initGetHttpData:(NSString*)time
{
    self = [super init];
    if (self) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy,MM,dd,HH,mm"];
        
        NSTimeInterval interval=[[time substringToIndex:10] doubleValue];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSString *dateString = [formatter stringFromDate:date];
        
        NSArray *array=[[NSArray alloc]init];
        array=[dateString componentsSeparatedByString:@","];
        self.year=[array[0] integerValue];
        self.month=[array[1] integerValue];
        self.day=[array[2] integerValue];
        self.hour=[array[3] integerValue];
        self.minute=[array[4] integerValue];
    }
    return self;
}

@end
