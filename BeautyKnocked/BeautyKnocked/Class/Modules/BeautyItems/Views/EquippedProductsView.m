//
//  EquippedProductsView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EquippedProductsView.h"

@interface EquippedProductsView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *firstContentlabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *secondContentLabel;

@end

@implementation EquippedProductsView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    
    _firstLabel = [[UILabel alloc] init];
    _firstLabel.textColor = [UIColor lightGrayColor];
    _firstLabel.font = [UIFont systemFontOfSize:Font_Size(33)];
    
    _firstContentlabel = [[UILabel alloc] init];
    _firstContentlabel.font = [UIFont systemFontOfSize:Font_Size(33)];
    _firstContentlabel.numberOfLines = 0;
    
    _secondLabel = [[UILabel alloc] init];
    _secondLabel.textColor = [UIColor lightGrayColor];
    _secondLabel.font = [UIFont systemFontOfSize:Font_Size(33)];
    
    _secondContentLabel = [[UILabel alloc] init];
    _secondContentLabel.font = [UIFont systemFontOfSize:Font_Size(33)];
    _secondContentLabel.numberOfLines = 0;
    
    [self addSubview:_titleLabel];
    [self addSubview:_line];
    [self addSubview:_firstLabel];
    [self addSubview:_firstContentlabel];
    [self addSubview:_secondLabel];
    [self addSubview:_secondContentLabel];
    
    _titleLabel.text = @"说明书";
    _firstLabel.text = @"左侧1";
    _firstContentlabel.text = @"你无法忍受放声大哭靠父母开发克里斯多夫尽快离开手机打开积分即可开了房SDK联发科";
    _secondLabel.text = @"左侧2";
    _secondContentLabel.text = @"各环节的首付款两三点开放开发了开发商看来发个克里斯多夫看了;圣诞快乐;看了; 看了;烦死了快递费快乐";
    
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(30));
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.height.mas_equalTo(0.5);
    }];
    
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_line.mas_bottom).with.offset(Height_Pt(25));
        make.width.mas_equalTo(Width_Pt(202));
        make.height.mas_equalTo(Height_Pt(35));
    }];
    
    [_firstContentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstLabel.mas_right);
        make.top.equalTo(_firstLabel.mas_top);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
    }];
    
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_secondContentLabel.mas_top);
        make.size.equalTo(_firstLabel);
    }];
    
    [_secondContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstContentlabel.mas_bottom).with.offset(Height_Pt(40));
        make.left.equalTo(_secondLabel.mas_right);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.bottom.equalTo(self).with.offset( - Width_Pt(40));
    }];
    
    
}

-(void)setTitleName:(NSString *)titleName {
    _titleLabel.text = titleName;
}
-(void)setFirstTitle:(NSString *)firstTitle {
    _firstLabel.text = firstTitle;
}
-(void)setFirstContent:(NSString *)firstContent {
    _firstContentlabel.text = firstContent;
}

-(void)setSecondTitle:(NSString *)secondTitle {
    _secondLabel.text = secondTitle;
}
-(void)setSecondContent:(NSString *)secondContent {
    _secondContentLabel.text = secondContent;
}

@end
