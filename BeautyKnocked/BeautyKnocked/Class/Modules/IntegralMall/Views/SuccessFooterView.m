//
//  SuccessFooterView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SuccessFooterView.h"
#import "UIView+CornerRadius.h"

@interface SuccessFooterView ()
@property (nonatomic, strong) UIButton *exchangeAggain;
@property (nonatomic, strong) UIButton *checkRecording;
@end

@implementation SuccessFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    _exchangeAggain = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exchangeAggain setBackgroundImage:[UIImage imageNamed:@"duihuankuang"] forState:UIControlStateNormal];
    _exchangeAggain.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_exchangeAggain setTitle:@"继续兑换" forState:UIControlStateNormal];
    [_exchangeAggain makeCornerRadius:6];
    
    _checkRecording = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkRecording setBackgroundImage:[UIImage imageNamed:@"jilukuang"] forState:UIControlStateNormal];
    _checkRecording.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_checkRecording setTitle:@"查看兑换记录" forState:UIControlStateNormal];
    [_checkRecording setTitleColor:ThemeColor forState:UIControlStateNormal];
    
    // events
    [[_exchangeAggain rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([self.delegate respondsToSelector:@selector(successFooterViewClicked:)]) {
            [self.delegate successFooterViewClicked:1];
        }
    }];
    
    [[_checkRecording rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([self.delegate respondsToSelector:@selector(successFooterViewClicked:)]) {
            [self.delegate successFooterViewClicked:2];
        }
    }];
    
    [self addSubview:_exchangeAggain];
    [self addSubview:_checkRecording];
}
-(void)addConstraints {
    
    [@[_exchangeAggain,_checkRecording] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(54));
        make.right.equalTo(self).with.offset( - Width_Pt(54));
        make.height.mas_equalTo(Height_Pt(150));
    }];
    
    [_exchangeAggain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(60));
    }];
    
    [_checkRecording mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_exchangeAggain.mas_bottom).with.offset(Height_Pt(40));
    }];
}


@end
