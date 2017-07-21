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


@interface LoginController ()

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UITextField *usernameTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *registerAccountBtn;

@property (nonatomic, strong) UIButton *forgetPasswordBtn;

@end

@implementation LoginController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除 navigationBar 底部的细线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalImageName:@"quxiao_03"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    
    [self addSubViews];
    
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSubViews {
    
    [self.view addSubview:self.backImgView];
    
    [self.backImgView addSubview:self.logoImgView];
    
    [self.backImgView addSubview:self.usernameTextField];
    [self.backImgView addSubview:self.passwordTextField];
    [self.backImgView addSubview:self.loginBtn];
    
    [self.backImgView addSubview:self.registerAccountBtn];
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

    [_registerAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).with.offset(Height_Pt(108));
        make.left.equalTo(_loginBtn.mas_left);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_registerAccountBtn);
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
        [_usernameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_usernameTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _usernameTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _usernameTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yonghu_03"];
        _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _usernameTextField;
}

-(UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        [_passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _passwordTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _passwordTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"mima_03"];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _passwordTextField;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_loginBtn setBackgroundImage:[UIImage imageNamed:@"denglu-anniu_03"] forState:UIControlStateNormal];
        [_loginBtn setImage:[UIImage imageNamed:@"denglu-anniu_03"] forState:UIControlStateNormal];
        
    }
    return _loginBtn;
}

-(UIButton *)registerAccountBtn {
    if (!_registerAccountBtn) {
        _registerAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerAccountBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerAccountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        
        [[_registerAccountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.navigationController pushViewController:[[RegisterController alloc] init] animated:YES];
        }];
        
    }
    return _registerAccountBtn;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
