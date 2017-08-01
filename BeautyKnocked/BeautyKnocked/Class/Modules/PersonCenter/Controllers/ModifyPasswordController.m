//
//  ModifyPasswordController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "TextField.h"


@interface ModifyPasswordController ()<UITextFieldDelegate>

@property (nonatomic, strong) TextField *currentPasswordTF;

@property (nonatomic, strong) TextField *passwordTF;

@property (nonatomic, strong) TextField *confirmPasswordTF;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation ModifyPasswordController

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
    _currentPasswordTF = [TextField textFieldWithPlaceholder:@"当前密码" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _currentPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    _currentPasswordTF.secureTextEntry=YES;
    _currentPasswordTF.delegate=self;
    
    _passwordTF = [TextField textFieldWithPlaceholder:@"新密码" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTF.secureTextEntry=YES;
    _passwordTF.delegate=self;
    
    _confirmPasswordTF = [TextField textFieldWithPlaceholder:@"确认新密码" textSize:Font_Size(48) borderColor:[UIColor colorWithHexString:@"#E1C06C"]];
    _confirmPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
    _confirmPasswordTF.secureTextEntry=YES;
    _confirmPasswordTF.delegate=self;
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= 17) {
        textField.text = [textField.text substringToIndex:17];
    }
    return YES;
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
