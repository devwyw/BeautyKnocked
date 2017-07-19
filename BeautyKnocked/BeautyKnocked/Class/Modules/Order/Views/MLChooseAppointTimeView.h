//
//  MLChooseAppointTimeView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MMPopupView.h"

@protocol MLChooseAppointTimeViewDelegate <NSObject>

-(void)shouldHideBackDetailDate:(NSString *)detailDate;

@end

@interface MLChooseAppointTimeView : MMPopupView

@property (nonatomic, copy) NSString *selectedDate;
@property (nonatomic, weak) id<MLChooseAppointTimeViewDelegate> delegate;

@end
