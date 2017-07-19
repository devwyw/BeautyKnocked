//
//  BeauticianRegisterSexView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BeauticianSex) {
    Female,
    Male,
};

@interface BeauticianRegisterSexView : UIView

@property (nonatomic, assign) BeauticianSex sex;

@end
