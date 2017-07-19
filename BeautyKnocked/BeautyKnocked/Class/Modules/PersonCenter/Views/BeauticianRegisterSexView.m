//
//  BeauticianRegisterSexView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianRegisterSexView.h"

@interface BeauticianRegisterSexView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *maleButton;

@property (nonatomic, strong) UIButton *femaleButton;

@end

@implementation BeauticianRegisterSexView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    UIFont *font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = font;
    [self addSubview:_titleLabel];
    _titleLabel.text = @"性别";
    
    _femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_femaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _femaleButton.titleLabel.font = font;
    [self addSubview:_femaleButton];
    
    _maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _maleButton.titleLabel.font = font;
    [self addSubview:_maleButton];
    
    [_femaleButton addTarget:self action:@selector(sexButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_maleButton addTarget:self action:@selector(sexButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_femaleButton setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_femaleButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_femaleButton setTitle:@"女" forState:UIControlStateNormal];
    
    [_maleButton setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_maleButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_maleButton setTitle:@"男" forState:UIControlStateNormal];
    
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(45));
        make.centerY.equalTo(self);
    }];
    
    [_femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(335));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(Width_Pt(103));
        make.height.mas_equalTo(Width_Pt(45));
    }];
    
    [_maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_femaleButton.mas_right).with.offset(Width_Pt(170));
        make.centerY.equalTo(self);
        make.width.equalTo(_femaleButton);
        make.height.equalTo(_femaleButton);
    }];
    
}


-(void)sexButtonClicked:(UIButton *)button {
    
    _femaleButton.selected = NO;
    _maleButton.selected = NO;
    button.selected = YES;
}

-(BeauticianSex)sex {
    
    if (_femaleButton.selected) {
        return Female;
    }
    return Male;
}

@end
