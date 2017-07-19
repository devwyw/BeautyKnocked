//
//  LoginPasswordView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LoginPasswordView.h"

@interface LoginPasswordView ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *indicateView;

@end

@implementation LoginPasswordView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createViews];
        [self addConstraints];
    }
    return self;
}

-(void)createViews {
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor lightGrayColor];
    _textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_textLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_detailLabel];
    
    _indicateView = [[UIImageView alloc] init];
    [_indicateView setImage:[UIImage imageNamed:@"gengduo"]];
    [self addSubview:_indicateView];
    
    _textLabel.text = @"登录密码";
    
}

-(void)addConstraints {
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(75));
        make.centerY.equalTo(self);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(372));
        make.centerY.equalTo(self);
    }];
    
    [_indicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(64));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(26), Height_Pt(46)));
    }];

}

-(void)setPasswordStatus:(NSString *)passwordStatus {
    _detailLabel.text = passwordStatus;
}

@end
