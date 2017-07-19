//
//  ClassItemCollectionCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ClassItemCollectionCell.h"
#import "NSString+Attribute.h"

@interface ClassItemCollectionCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *monthSaleLabel;

@end

@implementation ClassItemCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"水美人";
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    NSString *text = @"VIP: ¥88 ¥500";
    _priceLabel.attributedText = [text setRedPrice:@"¥88" linePrice:@"¥500"];
    [self.contentView addSubview:_priceLabel];
    
    _monthSaleLabel = [[UILabel alloc] init];
    _monthSaleLabel.textColor = [UIColor lightGrayColor];
    _monthSaleLabel.text = @"5人购买";
    _monthSaleLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    [self.contentView addSubview:_monthSaleLabel];
    
}

-(void)setupConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(Height_Pt(510));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).with.offset(Height_Pt(16));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(18));
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(20));
        make.height.mas_equalTo(Height_Pt(32));
    }];
    
    [_monthSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLabel);
        make.right.equalTo(self.contentView).with.offset( - Height_Pt(48));
        make.height.mas_equalTo(Height_Pt(32));
    }];
    
}


@end
