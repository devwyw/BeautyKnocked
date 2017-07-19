//
//  FightGroupHourglassShareView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FightGroupHourglassShareView : UIView

@property (nonatomic, copy) NSAttributedString *hourglass;
@property (nonatomic, copy) NSAttributedString *people;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) void (^FightGroupShareBlock)(NSUInteger);

@end
