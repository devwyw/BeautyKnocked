//
//  AddressToDefaultView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddressToDefaultView.h"

@interface AddressToDefaultView ()
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation AddressToDefaultView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultButton setImage:[UIImage imageNamed:@"address_weixuanzhong"] forState:UIControlStateNormal];
    [_defaultButton setImage:[UIImage imageNamed:@"address_xuanzhong"] forState:UIControlStateSelected];
    
    @weakify(self);
    [[_defaultButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable button) {
        @strongify(self);
        button.selected = !button.selected;
        self.isDefaultAddress = button.selected;
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _titleLabel.text = @"设置为默认收货地址";
    
    [self addSubview:_defaultButton];
    [self addSubview:_titleLabel];
}
-(void)addConstraints {
    [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(50));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_defaultButton.mas_right).with.offset(8);
        make.centerY.equalTo(self);
    }];
}

-(void)setIsDefaultAddress:(BOOL)isDefaultAddress {
    _defaultButton.selected = isDefaultAddress;
}

@end
