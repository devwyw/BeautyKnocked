//
//  BeauticianRegisterExpertiseView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianRegisterExpertiseView.h"


@interface BeauticianRegisterExpertiseView ()

@property (nonatomic, strong) UILabel *titleLabel;
/**
 beautician exppertise
 */
@property (nonatomic, strong) UIButton *nailButton;
@property (nonatomic, strong) UIButton *beautyButton;
@property (nonatomic, strong) UIButton *hairdressingButton;
@property (nonatomic, strong) UIButton *bodyButton;
@property (nonatomic, strong) UIButton *manualButton;
@property (nonatomic, strong) UIButton *othersButton;

@end

@implementation BeauticianRegisterExpertiseView

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
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_titleLabel];
    
    _titleLabel.text = @"您的专长(多选)";
    
    _nailButton = [self initializeExpertiseButtonWithTitle:@"美甲"];
    
    
    _beautyButton = [self initializeExpertiseButtonWithTitle:@"美容"];
    
    
    _hairdressingButton = [self initializeExpertiseButtonWithTitle:@"美发"];
    
    
    _bodyButton = [self initializeExpertiseButtonWithTitle:@"美体"];
    
    
    _manualButton = [self initializeExpertiseButtonWithTitle:@"手工"];
    
    
    _othersButton = [self initializeExpertiseButtonWithTitle:@"其他"];
    
    [self addSubview:_nailButton];
    [self addSubview:_beautyButton];
    [self addSubview:_hairdressingButton];
    [self addSubview:_bodyButton];
    [self addSubview:_manualButton];
    [self addSubview:_othersButton];
    
    [_nailButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_beautyButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_hairdressingButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bodyButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_manualButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_othersButton addTarget:self action:@selector(expertiseClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(45));
        make.top.equalTo(self).with.offset(Height_Pt(36));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_beautyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(70));
    }];
    
    [_nailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_beautyButton.mas_left).with.offset( - Width_Pt(218));
        make.centerY.equalTo(_beautyButton);
    }];
    
    [_hairdressingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_beautyButton.mas_right).with.offset(Width_Pt(218));
        make.centerY.equalTo(_beautyButton);
    }];
    
    [_manualButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_beautyButton.mas_bottom).with.offset(Height_Pt(70));
        //make.bottom.equalTo(self).with.offset( - Height_Pt(40));
    }];
    
    [_bodyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_manualButton.mas_left).with.offset( - Width_Pt(218));
        make.centerY.equalTo(_manualButton);
    }];
    
    [_othersButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_manualButton);
        make.left.equalTo(_manualButton.mas_right).with.offset(Width_Pt(218));
    }];
    
    NSArray  *views = @[_beautyButton,_nailButton,_hairdressingButton,_manualButton,_bodyButton,_othersButton];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Pt(154), Height_Pt(48)));
    }];
    
}

-(UIButton *)initializeExpertiseButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [button setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

-(void)expertiseClicked:(UIButton *)button {
    button.selected = !button.selected;
}

@end
