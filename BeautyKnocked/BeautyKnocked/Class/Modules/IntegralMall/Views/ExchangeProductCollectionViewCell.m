//
//  ExchangeProductCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeProductCollectionViewCell.h"
#import "CouponImageView.h"

@interface ExchangeProductCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) CouponImageView *couponImgView;

@end
@implementation ExchangeProductCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)setProductName:(NSString *)productName {
    _titleLabel.text = productName;
    [_couponImgView setProductName:productName];
}
-(NSString *)productName {
    return _titleLabel.text;
}
-(void)setIntegralPrice:(NSString *)integralPrice {
    _integralLabel.text = integralPrice;
}
-(void)setCouponImageName:(NSString *)couponImageName {
    [_couponImgView setImage:[UIImage imageNamed:couponImageName]];
}

-(void)setOffsetValue:(NSString *)offsetValue {
    [_couponImgView setOffset:offsetValue];
}

-(void)setCapacity:(NSString *)capacity {
    _titleLabel.text = [NSString stringWithFormat:@"%@ %@",self.productName,capacity];
}

-(void)initializeViews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _integralLabel = [[UILabel alloc] init];
    _integralLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    
    _couponImgView = [[CouponImageView alloc] init];
    
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_integralLabel];
    [self.contentView addSubview:_couponImgView];
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(38));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(35));
        make.height.mas_equalTo(Height_Pt(47));
    }];
    
    [_integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(15));
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_couponImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_integralLabel.mas_bottom).with.offset(Height_Pt(55));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(63));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(66));
        make.height.mas_equalTo(Height_Pt(213));
    }];
    
}

@end
