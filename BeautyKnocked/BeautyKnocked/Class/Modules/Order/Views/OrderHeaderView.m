//
//  OrderHeaderView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView ()
@property (nonatomic,strong) UILabel * titleLbel;

@end

@implementation OrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _titleLbel=[[UILabel alloc]init];
    [_titleLbel setTextColor:[UIColor grayColor]];
    _titleLbel.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self addSubview:_titleLbel];
}
-(void)addConstraints {
    [_titleLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-5);
    }];
}
-(void)setTitle:(NSString *)title{
    _titleLbel.text=title;
}
@end
