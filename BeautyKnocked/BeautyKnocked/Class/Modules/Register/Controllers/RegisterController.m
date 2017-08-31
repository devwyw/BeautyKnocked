//
//  RegisterController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RegisterController.h"
#import "UIImageView+Category.h"
#import "UIImage+Original.h"
#import "UserAgreementController.h"
#import "UITextField+Length.h"
#import "NSString+Attribute.h"
#import "LoginController.h"

@interface RegisterController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIButton * getCode;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSDate *beforeDate;

@property (nonatomic, strong) UITextField *varificationCodeTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UITextField *confirmPasswordTextField;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *bookBtn;

@end

static int const timeCode = 60;

@implementation RegisterController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha=@"0";
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopTime];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTime];
}
-(void)setupNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBG) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterFG) name:UIApplicationWillEnterForegroundNotification object:nil];
}
-(void)enterBG {
    _beforeDate = [NSDate date];
}
-(void)enterFG {
    NSDate * now = [NSDate date];
    int interval = (int)ceil([now timeIntervalSinceDate:_beforeDate]);
    int val = (int)_time - interval;
    if(val > 0){
        _time -= interval;
    }else{
        _time = 0;
        [self stopTime];
        [_getCode setTitle:@"重新发送" forState:UIControlStateNormal];
        _getCode.userInteractionEnabled=YES;
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalImageName:@"quxiao_03"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
    
    [self addSubViews];
    [self addConstraints];
}
-(void)returnAction{
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
    [self.backImgView addSubview:self.bookBtn];
    if (!_isType) {
        self.bookBtn.hidden=YES;
    }
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
        make.size.equalTo(_phoneNumberTextField);
    }];
    
    // password
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_varificationCodeTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_phoneNumberTextField);
    }];
    
    // confirm password
    [_confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_phoneNumberTextField);
    }];
    
    // register
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPasswordTextField.mas_bottom).with.offset(Height_Pt(45));
        make.centerX.equalTo(_backImgView);
        make.size.equalTo(_phoneNumberTextField);
    }];

    // 用户协议
    [_bookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-Height_Pt(120));
        make.height.mas_equalTo(Height_Pt(35));
        make.left.right.equalTo(self.view);
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
        _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumberTextField.delegate=self;
        _phoneNumberTextField.textColor=[UIColor whiteColor];
        _phoneNumberTextField.placeholder = @"手机号码";
        [_phoneNumberTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneNumberTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _phoneNumberTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _phoneNumberTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yonghu_03"];
        _phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
        [[_phoneNumberTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [_phoneNumberTextField setFieldtext:11];
        }];
        
        _getCode=[[UIButton alloc]initWithFrame:CGRectMake(0, 1.4, 80, Height_Pt(122)-2.8)];
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCode.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_getCode setBackgroundImage:[UIImage imageNamed:@"huoquyanzhengma"] forState:UIControlStateNormal];
        [_getCode addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
        _phoneNumberTextField.rightView=_getCode;
        _phoneNumberTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _phoneNumberTextField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_phoneNumberTextField) {
        return [textField setRange:range whitString:string whitCount:11];
    }else if (textField==_varificationCodeTextField){
        return [textField setRange:range whitString:string whitCount:4];
    }else{
       return [textField setRange:range whitString:string whitCount:18];
    }
}
#pragma mark ===== 获取验证码 =====
-(void)getCode:(UIButton*)btn{
    if (_phoneNumberTextField.text.length==11&&[_phoneNumberTextField.text isMobileNumber]) {
        NSString *code=_isType ? zcyzm : ptyzm ;
        [Master HttpPostRequestByParams:@{@"phone":_phoneNumberTextField.text} url:mlqqm serviceCode:code Success:^(id json) {
            btn.userInteractionEnabled=NO;
            _time = timeCode;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [Master showSVProgressHUD:@"验证码获取成功" withType:ShowSVProgressTypeSuccess withShowBlock:nil];
        } Failure:nil andNavigation:self.navigationController];
    }else{
        [Master showSVProgressHUD:@"请输入有效的11位手机号" withType:ShowSVProgressTypeInfo withShowBlock:nil];
    }
}
-(void)timeCount{
    if (_time==0)return;
    _time--;
    switch (_time) {
        case 0:
        {
            [self stopTime];
            [_getCode setTitle:@"重新发送" forState:UIControlStateNormal];
            _getCode.userInteractionEnabled=YES;
        }
            break;
        default:
        {
            [_getCode setTitle:[NSString stringWithFormat:@"已发送%lds",_time] forState:UIControlStateNormal];
        }
            break;
    }
}
-(void)stopTime{
    if (_timer) {
        [_timer invalidate];
    }
}
-(UITextField *)varificationCodeTextField {
    if (!_varificationCodeTextField) {
        _varificationCodeTextField = [[UITextField alloc] init];
        _varificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _varificationCodeTextField.placeholder = @"请输入验证码";
        _varificationCodeTextField.delegate=self;
        _varificationCodeTextField.textColor=[UIColor whiteColor];
        [_varificationCodeTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_varificationCodeTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _varificationCodeTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _varificationCodeTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"yanzhengma_03"];
        _varificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        [[_varificationCodeTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [_varificationCodeTextField setFieldtext:4];
        }];
    }
    return _varificationCodeTextField;
}

-(UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.secureTextEntry=YES;
        _passwordTextField.delegate=self;
        _passwordTextField.textColor=[UIColor whiteColor];
        _passwordTextField.placeholder = @"请输入密码(6-18个数字)";
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

-(UITextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc] init];
        _confirmPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _confirmPasswordTextField.secureTextEntry=YES;
        _confirmPasswordTextField.delegate=self;
        _confirmPasswordTextField.textColor=[UIColor whiteColor];
        _confirmPasswordTextField.placeholder = @"再次确认密码";
        [_confirmPasswordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_confirmPasswordTextField setValue:[UIFont systemFontOfSize:14.f] forKeyPath:@"_placeholderLabel.font"];
        _confirmPasswordTextField.background = [UIImage imageNamed:@"shurukuang_03"];
        _confirmPasswordTextField.leftView = [UIImageView createLeftImgViewWithImageName:@"mima_03"];
        _confirmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        [[_confirmPasswordTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [_confirmPasswordTextField setFieldtext:18];
        }];
    }
    return _confirmPasswordTextField;
}
#pragma mark ===== 注册密码/忘记密码 =====
-(UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_isType) {
            [_registerBtn setImage:[UIImage imageNamed:@"zhuceanniu_03"] forState:UIControlStateNormal];
        }else{
            [_registerBtn setBackgroundImage:[UIImage imageNamed:@"zhucekuang"] forState:UIControlStateNormal];
            [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [_registerBtn setTitleColor:[UIColor colorWithHexString:@"#E8AB00"] forState:UIControlStateNormal];
            [_registerBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        }
        Weakify(self);
        [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (_phoneNumberTextField.text.length==11
                &&_varificationCodeTextField.text.length==4
                &&_passwordTextField.text.length>=6
                &&[_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]
                ) {
                if (_isType) {
                    [Master HttpPostRequestByParams:@{@"phone":_phoneNumberTextField.text,@"code":_varificationCodeTextField.text,@"password":_passwordTextField.text} url:mlqqm serviceCode:zc Success:^(id json) {
                        [Master showSVProgressHUD:@"注册成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                            [Wself dismissViewControllerAnimated:YES completion:^{
                                [Master HttpPostRequestByParams:@{@"account":_phoneNumberTextField.text,
                                                                  @"password":_passwordTextField.text
                                                                  }
                                                            url:mlqqm serviceCode:dl Success:^(id json) {
                                                                Acount *user=[Acount shareManager];
                                                                user=[Acount mj_objectWithKeyValues:json[@"info"]];
                                                                [user SignInAcount];
                                                                [Master setTabBarItem:0 withNavigationController:Wself.navigationController];
                                                            } Failure:nil andNavigation:Wself.navigationController];
                            }];
                        }];
                    } Failure:nil andNavigation:Wself.navigationController];
                }else{
                    [Master HttpPostRequestByParams:@{@"phone":_phoneNumberTextField.text,@"code":_varificationCodeTextField.text,@"password":_passwordTextField.text} url:mlqqm serviceCode:wjmm Success:^(id json) {
                        [Master showSVProgressHUD:@"重置成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                            [Wself.navigationController popViewControllerAnimated:YES];
                        }];
                    } Failure:nil andNavigation:Wself.navigationController];
                }
            }else{
                if (_phoneNumberTextField.text.length!=11) {
                    [Master showSVProgressHUD:@"请输入有效的11位手机号" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_varificationCodeTextField.text.length!=4){
                    [Master showSVProgressHUD:@"请输入有效的4位验证码" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_passwordTextField.text.length<6){
                    [Master showSVProgressHUD:@"您的密码小于6位" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]){
                    [Master showSVProgressHUD:@"确认密码与密码不相同" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }
            }
        }];
    }
    return _registerBtn;
}
-(UIButton *)bookBtn {
    if (!_bookBtn) {
        NSMutableAttributedString * normalStr = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意美丽敲敲门用户协议"];
        [normalStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:(NSRange){0,[normalStr length]}];
        [normalStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:NSMakeRange(0,[normalStr length])];
        [normalStr addAttribute:NSUnderlineColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[normalStr length])];
        [normalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, normalStr.length)];
        
        NSMutableAttributedString * HighStr = [[NSMutableAttributedString alloc] initWithString:@"注册即视为同意美丽敲敲门用户协议"];
        [HighStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:(NSRange){0,[HighStr length]}];
        [HighStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]  range:NSMakeRange(0,[HighStr length])];
        [HighStr addAttribute:NSUnderlineColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,[HighStr length])];
        [HighStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, HighStr.length)];
        
        _bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bookBtn setAttributedTitle:normalStr forState:UIControlStateNormal];
        [_bookBtn setAttributedTitle:HighStr forState:UIControlStateHighlighted];
        [_bookBtn addTarget:self action:@selector(bookPush:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bookBtn;
}
-(void)bookPush:(UIButton*)btn{
    UserAgreementController *controller=[[UserAgreementController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
