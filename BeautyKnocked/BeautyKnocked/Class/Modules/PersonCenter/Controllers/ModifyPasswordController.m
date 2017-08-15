//
//  ModifyPasswordController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "TextField.h"
#import "UITextField+Length.h"


@interface ModifyPasswordController ()<UITextFieldDelegate>

@property (nonatomic, strong) TextField *currentPasswordTF;

@property (nonatomic, strong) TextField *passwordTF;

@property (nonatomic, strong) TextField *confirmPasswordTF;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation ModifyPasswordController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title=@"修改密码";
    [self createViews];
    [self addViews];
    [self addConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createViews {
    Acount *user=[Acount shareManager];
    _currentPasswordTF = [TextField textFieldWithPlaceholder:@"当前密码" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _currentPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    _currentPasswordTF.secureTextEntry=YES;
    _currentPasswordTF.delegate=self;
    [[_currentPasswordTF rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_currentPasswordTF setFieldtext:18];
    }];
    
    _passwordTF = [TextField textFieldWithPlaceholder:@"请输入新密码(6-18个数字)" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTF.secureTextEntry=YES;
    _passwordTF.delegate=self;
    [[_passwordTF rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_passwordTF setFieldtext:18];
    }];
    
    _confirmPasswordTF = [TextField textFieldWithPlaceholder:@"确认新密码" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _confirmPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    _confirmPasswordTF.secureTextEntry=YES;
    _confirmPasswordTF.delegate=self;
    [[_confirmPasswordTF rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_confirmPasswordTF setFieldtext:18];
    }];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
    Weakify(self);
    [[_submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (_currentPasswordTF.text.length>=6
            &&_passwordTF.text.length>=6
            &&[_passwordTF.text isEqualToString:_confirmPasswordTF.text]
            ){
            if ([_currentPasswordTF.text isEqualToString:_passwordTF.text]) {
                [Master showSVProgressHUD:@"旧密码与新密码相同" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }else{
                [Master HttpPostRequestByParams:@{@"id":user.id,
                                                  @"device":UUID,
                                                  @"oldPassword":_currentPasswordTF.text,
                                                  @"newPassword":_passwordTF.text} url:mlqqm serviceCode:ggmm Success:^(id json) {
                                                      [Master showSVProgressHUD:@"修改成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                                                          [Wself.navigationController popViewControllerAnimated:YES];
                                                      }];
                                                      
                                                  } Failure:nil];
            }
        }else{
            if (_currentPasswordTF.text.length<6) {
                [Master showSVProgressHUD:@"当前密码小于6位" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }else if (_passwordTF.text.length<6){
                [Master showSVProgressHUD:@"新密码小于6位" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }else if (![_passwordTF.text isEqualToString:_confirmPasswordTF.text]){
                [Master showSVProgressHUD:@"确认密码与新密码不相同" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }
        }
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField setRange:range whitString:string whitCount:18];
}
-(void)addViews {
    [self.view addSubview:_currentPasswordTF];
    [self.view addSubview:_passwordTF];
    [self.view addSubview:_confirmPasswordTF];
    [self.view addSubview:_submitButton];
}

-(void)addConstraints {
    NSArray *views = @[_currentPasswordTF,_passwordTF,_confirmPasswordTF,_submitButton];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(Width_Pt(32));
        make.right.equalTo(self.view).with.offset( - Width_Pt(35));
    }];
    
    [_currentPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(Height_Pt(84));
        make.height.mas_equalTo(Height_Pt(152));
    }];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentPasswordTF.mas_bottom).with.offset(Height_Pt(40));
        make.height.equalTo(_currentPasswordTF.mas_height);
    }];
    
    [_confirmPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTF.mas_bottom).with.offset(Height_Pt(40));
        make.height.equalTo(_currentPasswordTF.mas_height);
    }];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPasswordTF.mas_bottom).with.offset(Height_Pt(40));
        make.height.mas_equalTo(Height_Pt(155));
    }];
    
}
@end
