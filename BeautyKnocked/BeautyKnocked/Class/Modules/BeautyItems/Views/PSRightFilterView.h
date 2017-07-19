//
//  PSRightFilterView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSRightFilterView : UIView

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) void (^filterBlock)();

@end
