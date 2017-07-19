//
//  IntegralSectionHeaderView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface IntegralSectionHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *integralBalance;

@property (nonatomic, strong) RACSignal *recordingSignal;

@end
