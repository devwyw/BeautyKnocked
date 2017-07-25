//
//  TopMessageView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "TopMessageView.h"

@interface TopMessageView ()

@property (nonatomic,strong) UILabel * label1;
@property (nonatomic,strong) UILabel * label2;
@property (nonatomic,strong) UILabel * label3;
@property (nonatomic,strong) UILabel * label4;

@end

@implementation TopMessageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _label1=[[UILabel alloc]init];
    _label1.font=[UIFont systemFontOfSize:Font_Size(40)];
    _label1.text=@"订单状态：";
    [self addSubview:_label1];
    
    _label2=[[UILabel alloc]init];
    _label2.font=[UIFont systemFontOfSize:Font_Size(40)];
    _label2.text=@"服务倒计时：";
    [self addSubview:_label2];
    
    _label3=[[UILabel alloc]init];
    _label3.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self addSubview:_label3];
    
    _label4=[[UILabel alloc]init];
    _label4.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self addSubview:_label4];
}
-(void)addConstraints {
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_top);
        make.left.equalTo(self.mas_centerX);
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_label2.mas_bottom);
        make.left.equalTo(self.mas_centerX);
    }];
}
-(void)setTitle1:(NSString *)title1{
    _label3.text=title1;
}
-(void)setTitle2:(NSString *)title2{
    _label4.text=title2;
}
@end
