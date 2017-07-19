//
//  EvaluationFooterView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/3.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationFooterView.h"

@interface EvaluationFooterView ()
@property (nonatomic, strong) UIButton *evaluationButton;
@end

@implementation EvaluationFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    _evaluationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_evaluationButton setTitle:@"查看全部评论" forState:UIControlStateNormal];
    [_evaluationButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_evaluationButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    _evaluationButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [self addSubview:_evaluationButton];
    
}
-(void)addConstraints {
    [_evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(self);
        make.height.mas_equalTo(Height_Pt(116));
        make.width.mas_equalTo(Width/2);
    }];
}

-(RACSignal *)checkAllEvaluationSignal {
    return [_evaluationButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
