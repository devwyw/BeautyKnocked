//
//  ToolItemView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ToolItemView.h"

@interface ToolItemView ()

@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) UIButton *shoppingCartBtn;

@property (nonatomic, strong) UIButton *shoppingAddressBtn;

@property (nonatomic, strong) UIButton *pointsMallBtn;

@end

@implementation ToolItemView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _collectBtn = [self configureWithTitle:@"收藏技师" image:@"shoucang_03"];
    [_collectBtn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    _collectBtn.tag = 1001;
    [self addSubview:_collectBtn];
    
    _shoppingCartBtn = [self configureWithTitle:@"我的购物车" image:@"gouwu_03"];
    [_shoppingCartBtn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    _shoppingCartBtn.tag = 1002;
    [self addSubview:_shoppingCartBtn];
    
    _shoppingAddressBtn = [self configureWithTitle:@"收货地址" image:@"dizhi_10"];
    [_shoppingAddressBtn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    _shoppingAddressBtn.tag = 1003;
    [self addSubview:_shoppingAddressBtn];
    
    _pointsMallBtn = [self configureWithTitle:@"积分商城" image:@"jifen_11"];
    [_pointsMallBtn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
    _pointsMallBtn.tag = 1004;
    [self addSubview:_pointsMallBtn];
}

-(void)setupConstraints {
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self);
        make.width.equalTo(@[_shoppingCartBtn,_shoppingAddressBtn,_pointsMallBtn]);
        make.height.equalTo(@[_shoppingCartBtn,_shoppingAddressBtn,_pointsMallBtn]);
    }];
    
    [_shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectBtn.mas_right).with.offset(1);
        make.right.and.top.equalTo(self);
    }];
    
    [_shoppingAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self);
        make.top.equalTo(_collectBtn.mas_bottom).with.offset(1);
    }];
    
    [_pointsMallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shoppingAddressBtn.mas_right).with.offset(1);
        make.right.and.bottom.equalTo(self);
        make.top.equalTo(_shoppingCartBtn.mas_bottom).with.offset(1);
    }];
    
}

-(UIButton *)configureWithTitle:(NSString *)title image:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:GetPT(45)];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

-(void)didClicked:(UIButton *)button {
    NSUInteger index = button.tag -1000;
    if ([self.delegate respondsToSelector:@selector(didChooseToolAtIndex:)]) {
        [self.delegate didChooseToolAtIndex:index];
    }
}

@end
