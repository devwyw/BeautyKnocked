//
//  MessageView.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MessageView.h"
#import <IQTextView.h>

@interface MessageView ()
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIButton * cancel;
@property (nonatomic,strong) IQTextView * textview;
@property (nonatomic,strong) UIButton * done;
@end

@implementation MessageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews{
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    [_backView makeCornerRadius:5];
    [self addSubview:_backView];
    
    _title=[[UILabel alloc]init];
    _title.text=@"反馈";
    _title.font=[UIFont systemFontOfSize:Font_Size(55)];
    [_backView addSubview:_title];
    
    _cancel=[[UIButton alloc]init];
    [_cancel setImage:[UIImage imageNamed:@"qu-xiao"] forState:UIControlStateNormal];
    [[_cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [LEEAlert closeWithCompletionBlock:nil];
    }];
    [_backView addSubview:_cancel];
    
    _textview=[[IQTextView alloc]init];
    [_textview makeCornerRadius:5];
    _textview.placeholder=@"您对美丽敲敲门服务平台是否存在什么疑问或困惑，请写下您的宝贵意见...";
    _textview.font=[UIFont systemFontOfSize:Font_Size(35)];
    _textview.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    [_backView addSubview:_textview];
    
    _done=[[UIButton alloc]init];
    [_done makeCornerRadius:5];
    [_done setTitle:@"提交" forState:UIControlStateNormal];
    [_done setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _done.titleLabel.font=[UIFont systemFontOfSize:Font_Size(50)];
    _done.backgroundColor=[UIColor colorWithHexString:@"#E1BF6E"];
    [_backView addSubview:_done];
}
-(void)addConstraints {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self).offset(Width_Pt(50));
        make.right.equalTo(self).offset(-Width_Pt(50));
        make.height.mas_equalTo(Height_Pt(903));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView).offset(Height_Pt(45));
        make.centerX.equalTo(_backView);
    }];
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title);
        make.right.equalTo(_backView).offset(-Width_Pt(60));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(60), Height_Pt(60)));
    }];
    
    [_done mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.bottom.equalTo(_backView.mas_bottom).offset(-Height_Pt(40));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(365), Height_Pt(100)));
    }];
    
    [_textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(85));
        make.left.equalTo(_backView).offset(Width_Pt(40));
        make.right.equalTo(_backView).offset(-Width_Pt(40));
        make.bottom.equalTo(_done.mas_top).offset(-Height_Pt(40));
    }];
}

@end
