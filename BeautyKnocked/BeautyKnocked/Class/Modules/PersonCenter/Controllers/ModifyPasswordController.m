//
//  ModifyPasswordController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "UITextField+Category.h"


@interface ModifyPasswordController ()

@property (nonatomic, strong) UITextField *currentPasswordTF;

@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UITextField *confirmPasswordTF;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViews];
    [self addViews];
    [self addConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createViews {
    
    _currentPasswordTF = [UITextField textFieldWithPlaceholder:@"当前密码" textSize:Font_Size(48) borderColor:[UIColor orangeColor]];
    
    _passwordTF = [UITextField textFieldWithPlaceholder:@"新密码" textSize:Font_Size(48) borderColor:[UIColor orangeColor]];
    
    _confirmPasswordTF = [UITextField textFieldWithPlaceholder:@"确认新密码" textSize:Font_Size(48) borderColor:[UIColor orangeColor]];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_submitButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
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
