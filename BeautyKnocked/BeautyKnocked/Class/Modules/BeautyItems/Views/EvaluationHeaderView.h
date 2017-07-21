//
//  EvaluationHeaderView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/3.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface EvaluationHeaderView : UIView

@property (nonatomic, strong) RACSignal *checkAllEvaluationSignal;

@end
