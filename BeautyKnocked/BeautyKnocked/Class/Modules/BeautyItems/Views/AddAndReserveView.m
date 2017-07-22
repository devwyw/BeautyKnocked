//
//  AddAndReserveView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddAndReserveView.h"

@interface AddAndReserveView ()

@property (nonatomic, strong) UIButton *addShoppingCart;

@property (nonatomic, strong) UIButton *appointNow;

@end

@implementation AddAndReserveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeButtons];
        [self addConstraints];
    }
    return self;
}

-(void)initializeButtons {
    
    _addShoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addShoppingCart setImage:[UIImage imageNamed:@"jiarugouwuche"] forState:UIControlStateNormal];
    [_addShoppingCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    _addShoppingCart.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_addShoppingCart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addShoppingCart setBackgroundImage:[UIImage imageNamed:@"gouwuchekuang"] forState:UIControlStateNormal];
    [self addSubview:_addShoppingCart];
    
    _appointNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [_appointNow setTitle:@"立即预约" forState:UIControlStateNormal];
    _appointNow.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_appointNow setBackgroundImage:[UIImage imageNamed:@"yuyuekuang"] forState:UIControlStateNormal];
    [self addSubview:_appointNow];
    
}

-(void)addConstraints {
    
    [_addShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, Width/2));
    }];
    
    [_appointNow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, Width/2, 0, 0));
    }];
    
}

-(RACSignal *)reserveNowSignal {
    return [_appointNow rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)addCar{
    return [_addShoppingCart rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
