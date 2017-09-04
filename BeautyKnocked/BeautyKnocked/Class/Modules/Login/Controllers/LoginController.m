//
//  LoginController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "UIImageView+Category.h"
#import "UIImage+Original.h"
#import "UITextField+Length.h"
#import "NSString+Attribute.h"
#import "AppDelegate+JPush.h"

@interface LoginController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UITextField *usernameTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *registerselfBtn;

@property (nonatomic, strong) UIButton *forgetPasswordBtn;

@end

@implementation LoginController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.BarAlpha=@"0";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.BarColor=[ThemeColor toColorString];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalImageName:@"quxiao_03"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    [self addSubViews];
    [self addConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSubViews {
    [self.view addSubview:self.backImgView];
    [self.backImgView addSubview:self.logoImgView];
    [self.backImgView addSubview:self.usernameTextField];
    [self.backImgView addSubview:self.passwordTextField];
    [self.backImgView addSubview:self.loginBtn];
    [self.backImgView addSubview:self.registerselfBtn];
    [self.backImgView addSubview:self.forgetPasswordBtn];
}

-(void)addConstraints {
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImgView).with.offset(Height_Pt(256));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(269), Height_Pt(256)));
    }];
    
    [_usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgView.mas_bottom).with.offset(Height_Pt(156));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(794), Height_Pt(122)));
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(794), Height_Pt(122)));
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(794), Height_Pt(122)));
    }];

    [_registerselfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).with.offset(Height_Pt(108));
        make.left.equalTo(_loginBtn.mas_left);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_registerselfBtn);
        make.right.equalTo(_loginBtn.mas_right);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
}

-(UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"denglubj@3x" ofType:@"png"];
        UIImage *backImage = [UIImage imageWithContentsOfFile:path];
        _backImgView.userInteractionEnabled = YES;
        [_backImgView setImage:backImage];
    }
    return _backImgView;
}

-(UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] init];
        [_logoImgView setImage:[UIImage imageNamed:@"denglu-logo_03"]];
    }
    return _logoImgView;
}

-(UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.placeholder = @"请输入账号/手机号码";
        _usernameTextField.textColor=[UIColor whiteColor];
        _usernameTextField.delegate=self;
        _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _usernameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [_usernameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_usernameTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _usernameTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _usernameTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yonghu_03"];
        _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
        [[_usernameTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [_usernameTextField setFieldtext:11];
        }];
    }
    return _usernameTextField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_usernameTextField) {
        return [textField setRange:range whitString:string whitCount:11];
    }else{
        return [textField setRange:range whitString:string whitCount:18];
    }
}
-(UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.textColor=[UIColor whiteColor];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.delegate=self;
        _passwordTextField.secureTextEntry=YES;
        [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _passwordTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"mima_03"];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [_passwordTextField setFieldtext:18];
        }];
    }
    return _passwordTextField;
}
#pragma mark ===== 登录 =====
-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:[UIImage imageNamed:@"denglu-anniu_03"] forState:UIControlStateNormal];
        Weakify(self);
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (_usernameTextField.text.length==11&&_passwordTextField.text.length>=6){
                [Master HttpPostRequestByParams:@{@"account":_usernameTextField.text,
                                                  @"password":_passwordTextField.text}
                                            url:mlqqm serviceCode:dl Success:^(id json) {
                                                Acount *user=[Acount shareManager];
                                                user=[Acount mj_objectWithKeyValues:json[@"info"]];
                                                [user SignInAcount];
                                                /** 极光推送设置别名Tag */
                                                [JPUSHService setAlias:[NSString stringWithFormat:@"cj%@",user.id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                                                    NSLog(@"极光推送:%@",iAlias);
                                                } seq:[user.id integerValue]];
                                                [Master showSVProgressHUD:@"登陆成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                                                    [Wself dismissViewControllerAnimated:YES completion:^{
                                                        [Master setTabBarItem:0 withNavigationController:Wself.navigationController];
                                                    }];
                                                }];
                } Failure:nil andNavigation:Wself.navigationController];
            }else{
                if (_usernameTextField.text.length!=11) {
                    [Master showSVProgressHUD:@"请输入有效的11位手机号" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_passwordTextField.text.length<6){
                    [Master showSVProgressHUD:@"您的密码小于6位" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }
            }
        }];
    }
    return _loginBtn;
}

-(UIButton *)registerselfBtn {
    if (!_registerselfBtn) {
        _registerselfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerselfBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerselfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerselfBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _registerselfBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [[_registerselfBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            RegisterController *controller=[[RegisterController alloc]init];
            controller.isType=YES;
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
    return _registerselfBtn;
}

-(UIButton *)forgetPasswordBtn {
    if (!_forgetPasswordBtn) {
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [[_forgetPasswordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            RegisterController *controller=[[RegisterController alloc]init];
            controller.isType=NO;
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
    return _forgetPasswordBtn;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
