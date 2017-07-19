//
//  FightGroupRulesTitleView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupRulesTitleView.h"

@interface FightGroupRulesTitleView ()

@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImgView;

@end

@implementation FightGroupRulesTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _leftImgView = [[UIImageView alloc] init];
    [_leftImgView setImage:[UIImage imageNamed:@"left-xian"]];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _titleLabel.text = @"拼团活动规则";
    
    _rightImgView = [[UIImageView alloc] init];
    [_rightImgView setImage:[UIImage imageNamed:@"right-xian"]];
    
    [self addSubview:_leftImgView];
    [self addSubview:_rightImgView];
    [self addSubview:_titleLabel];
}
-(void)addConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_titleLabel.mas_left).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(137), Height_Pt(24)));
    }];
    
    [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).with.offset(8);
        make.size.equalTo(_leftImgView);
    }];
}

@end
