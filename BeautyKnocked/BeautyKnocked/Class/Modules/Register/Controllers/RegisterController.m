//
//  RegisterController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RegisterController.h"
#import "UIImageView+Category.h"

@interface RegisterController ()

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UITextField *varificationCodeTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UITextField *confirmPasswordTextField;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *loginAccountBtn;

@property (nonatomic, strong) UIButton *forgetPasswordBtn;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalImageName:@"quxiao_03"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    
    [self addSubViews];
    [self addConstraints];
    
}

-(void)returnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addSubViews {
    
    [self.view addSubview:self.backImgView];
    
    [self.backImgView addSubview:self.logoImgView];
    
    [self.backImgView addSubview:self.phoneNumberTextField];
    [self.backImgView addSubview:self.varificationCodeTextField];
    [self.backImgView addSubview:self.passwordTextField];
    [self.backImgView addSubview:self.confirmPasswordTextField];
    [self.backImgView addSubview:self.registerBtn];
    
    [self.backImgView addSubview:self.loginAccountBtn];
    [self.backImgView addSubview:self.forgetPasswordBtn];
}

-(void)addConstraints {
    
    // background Image
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // logo
    [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImgView).with.offset(Height_Pt(256));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(269), Height_Pt(256)));
    }];

    // phone number
    [_phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgView.mas_bottom).with.offset(Height_Pt(156));
        make.centerX.equalTo(self.backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(794), Height_Pt(122)));
    }];
    
    // varification code
    [_varificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNumberTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(794), Height_Pt(122)));
    }];
    
    // password
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_varificationCodeTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_varificationCodeTextField);
    }];
    
    // confirm password
    [_confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_passwordTextField);
    }];
    
    // register
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPasswordTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_passwordTextField);
    }];
    
    // login account
    [_loginAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registerBtn.mas_bottom).with.offset(Height_Pt(108));
        make.left.equalTo(_registerBtn.mas_left);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    // forget password
    [_forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_loginAccountBtn);
        make.right.equalTo(_registerBtn.mas_right);
        make.height.mas_equalTo(Height_Pt(45));
    }];

}

#pragma mark setter && getter

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

-(UITextField *)phoneNumberTextField {
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[UITextField alloc] init];
        _phoneNumberTextField.placeholder = @"手机号码";
        [_phoneNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneNumberTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _phoneNumberTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _phoneNumberTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yonghu_03"];
        _phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneNumberTextField;
}

-(UITextField *)varificationCodeTextField {
    if (!_varificationCodeTextField) {
        _varificationCodeTextField = [[UITextField alloc] init];
        _varificationCodeTextField.placeholder = @"请输入验证码";
        [_varificationCodeTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_varificationCodeTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _varificationCodeTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _varificationCodeTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yanzhengma_03"];
        _varificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _varificationCodeTextField;
}

-(UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码(6-18个数字)";
        [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _passwordTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"mima_03"];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _passwordTextField;
}

-(UITextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc] init];
        _confirmPasswordTextField.placeholder = @"再次确认密码";
        [_confirmPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_confirmPasswordTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _confirmPasswordTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _confirmPasswordTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"mima_03"];
        _confirmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _confirmPasswordTextField;
}

-(UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setImage:[UIImage imageNamed:@"zhuceanniu_03"] forState:UIControlStateNormal];
        
    }
    return _registerBtn;
}

-(UIButton *)loginAccountBtn {
    if (!_loginAccountBtn) {
        _loginAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginAccountBtn setTitle:@"登录账号" forState:UIControlStateNormal];
        [_loginAccountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _loginAccountBtn;
}

-(UIButton *)forgetPasswordBtn {
    if (!_forgetPasswordBtn) {
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _forgetPasswordBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
