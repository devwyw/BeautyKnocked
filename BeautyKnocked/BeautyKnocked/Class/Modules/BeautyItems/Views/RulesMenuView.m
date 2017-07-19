//
//  RulesMenuView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RulesMenuView.h"

@interface RulesMenuView ()

@property (nonatomic, strong) UIButton *lateToUpgrade;
@property (nonatomic, strong) UIButton *indemnity;
@property (nonatomic, strong) UIButton *changeReserve;
@property (nonatomic, strong) UIButton *more;

@end

@implementation RulesMenuView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeButtons];
        [self addConstraints];
    }
    return self;
}

-(void)initializeButtons {
    
    _lateToUpgrade = [self createButtonWithImageName:@"chidaoshengji" title:@"迟到升级"];
    _indemnity = [self createButtonWithImageName:@"shaungyuepeichang" title:@"爽约赔款"];
    _changeReserve = [self createButtonWithImageName:@"yuyuebiangeng" title:@"预约变更"];
    _more = [self createButtonWithImageName:@"shenglvehao" title:@""];
    
    [self addSubview:_lateToUpgrade];
    [self addSubview:_indemnity];
    [self addSubview:_changeReserve];
    [self addSubview:_more];
}

-(void)addConstraints {
    
    NSArray *views = @[_lateToUpgrade,_indemnity,_changeReserve,_more];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(Height_Pt(159));
    }];
    
    [_lateToUpgrade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.width.equalTo(@[_indemnity,_changeReserve]);
    }];
    
    [_indemnity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lateToUpgrade.mas_right).with.offset(Width_Pt(60));
    }];
    
    [_changeReserve mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_indemnity.mas_right).with.offset(Width_Pt(60));
    }];
    
    [_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_changeReserve.mas_right).with.offset(Width_Pt(60));
        make.width.mas_equalTo(Width_Pt(62));
        make.right.equalTo(self).with.offset( - Width_Pt(38));
    }];
    
}

-(UIButton *)createButtonWithImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    return button;
}

@end
