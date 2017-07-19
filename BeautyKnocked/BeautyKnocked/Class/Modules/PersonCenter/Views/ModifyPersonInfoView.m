//
//  ModifyPersonInfoView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ModifyPersonInfoView.h"
#import "PersonInfoTextField.h"
#import "LoginPasswordView.h"

@interface ModifyPersonInfoView ()

@property (nonatomic, strong) UIButton *headIconButton;

@property (nonatomic, strong) UIImageView *cameraView;

@property (nonatomic, strong) PersonInfoTextField *nicknameTextField;

@property (nonatomic, strong) PersonInfoTextField *phoneTextField;

@property (nonatomic, strong) LoginPasswordView *loginPassword;

@end

@implementation ModifyPersonInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self addConstraints];
    }
    return self;
}

-(void)createViews {
    
    _headIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headIconButton setBackgroundImage:[UIImage imageNamed:@"touxiang_03"] forState:UIControlStateNormal];
    [self addSubview:_headIconButton];
    
    _cameraView = [[UIImageView alloc] init];
    _cameraView.image = [UIImage imageNamed:@"zhaopian"];
    [_headIconButton addSubview:_cameraView];
    
    _nicknameTextField = [[PersonInfoTextField alloc] init];
    _nicknameTextField.textName = @"昵称";
    [self addSubview:_nicknameTextField];
    
    _phoneTextField = [[PersonInfoTextField alloc] init];
    _phoneTextField.textName = @"手机号码";
    [self addSubview:_phoneTextField];
    
    _loginPassword = [[LoginPasswordView alloc] init];
    [self addSubview:_loginPassword];
    _loginPassword.passwordStatus = @"已设置";
    
   _passwordPressSignal = [_loginPassword rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    _headIconPressSignal = [_headIconButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addConstraints {
    
    [_headIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(88));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(228), Height_Pt(228)));
    }];
    
    [_cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headIconButton.mas_right);
        make.bottom.equalTo(_headIconButton.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(56), Height_Pt(56)));
    }];
    
    [_nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIconButton.mas_bottom).with.offset(Height_Pt(57));
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(147));
    }];
    
    //CGFloat onePX = 1.0 / [UIScreen mainScreen].scale / 2;
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nicknameTextField.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(147));
    }];
    
    [_loginPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTextField.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(147));
    }];
    
}


@end
