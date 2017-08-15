//
//  ProductTitlePriceView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ProductTitlePriceView.h"

@interface ProductTitlePriceView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ProductTitlePriceView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    _titleLabel.text = [NSString stringWithFormat:@"【%@】",title];
}
-(void)setPrice:(NSString *)price{
    _priceLabel.text = [NSString stringWithFormat:@"VIP价: ¥%@",price];
}
-(void)initializeViews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _priceLabel.textColor = [UIColor redColor];
    
    [self addSubview:_titleLabel];
    [self addSubview:_priceLabel];
}

-(void)addConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.centerY.equalTo(self);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(25));
    }];
}

@end
