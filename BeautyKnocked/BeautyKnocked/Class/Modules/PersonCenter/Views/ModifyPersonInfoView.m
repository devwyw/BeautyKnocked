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
#import "UIView+CornerRadius.h"

@interface ModifyPersonInfoView ()

@property (nonatomic, strong) UIButton *headIconButton;
@property (nonatomic, strong) UIImageView * headIcon;
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
-(void)setHeaderimage:(UIImage *)headerimage{
    [_headIcon setImage:headerimage];
}
-(void)setNavigationController:(UINavigationController *)navigationController{
    _navigationController=navigationController;
    _nicknameTextField.navigationController=navigationController;
}
-(void)createViews {
    Acount *user=[Acount shareManager];
    
    _headIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_headIconButton];
    
    _headIcon=[[UIImageView alloc]init];
    [_headIcon setContentMode:UIViewContentModeScaleAspectFill];
    [_headIcon setClipsToBounds:YES];
    [_headIcon makeCornerRadius:Width_Pt(228)/2];
    [Master GetWebImage:_headIcon withUrl:user.headPath];
    [_headIconButton addSubview:_headIcon];
    
    _cameraView = [[UIImageView alloc] init];
    _cameraView.image = [UIImage imageNamed:@"zhaopian"];
    _cameraView.contentMode=UIViewContentModeScaleAspectFit;
    [_headIconButton addSubview:_cameraView];
    
    _nicknameTextField = [[PersonInfoTextField alloc] init];
    _nicknameTextField.textName = @"昵称";
    _nicknameTextField.text=user.nickName;
    [self addSubview:_nicknameTextField];
    
    _phoneTextField = [[PersonInfoTextField alloc] init];
    _phoneTextField.userInteractionEnabled=NO;
    _phoneTextField.textName = @"手机号码";
    _phoneTextField.text=user.account;
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
    
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headIconButton);
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
