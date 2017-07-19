//
//  FightGroupTitleView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupTitleView.h"

@interface FightGroupTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rangeLabel;
@property (nonatomic, strong) UILabel *numberOfTimesLabel;
@property (nonatomic, strong) UIImageView *groupImgview;
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end
@implementation FightGroupTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _rangeLabel = [[UILabel alloc] init];
    //_rangeLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _rangeLabel.textColor = [UIColor redColor];
    _rangeLabel.adjustsFontSizeToFitWidth = YES;
    
    _numberOfTimesLabel = [[UILabel alloc] init];
    _numberOfTimesLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _numberOfTimesLabel.textColor = [UIColor lightGrayColor];
    
    _groupImgview = [[UIImageView alloc] init];
    [_groupImgview setImage:[UIImage imageNamed:@"rentou"]];
    
    _peopleLabel = [[UILabel alloc] init];
    _peopleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _peopleLabel.textColor = [UIColor lightGrayColor];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor lightGrayColor];
    
    
    [self addSubview:_titleLabel];
    [self addSubview:_rangeLabel];
    [self addSubview:_numberOfTimesLabel];
    [self addSubview:_groupImgview];
    [self addSubview:_peopleLabel];
    [self addSubview:_priceLabel];
    
    _titleLabel.text = @"[补水嫩肤]水漾海洋特润";
    _rangeLabel.text = @"该项目所有用户均可开团,开团后快邀请好友一起参团吧!";
    _numberOfTimesLabel.text = @"#每人限购1次#";
    _peopleLabel.text = @"5人团";
    _priceLabel.text = @"¥108 市场价 ¥385";
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(40));
        make.left.equalTo(self).with.offset(Width_Pt(30));
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(33));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self).with.offset( - 10);
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_numberOfTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rangeLabel.mas_bottom).with.offset(Height_Pt(33));
        make.left.equalTo(_rangeLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_groupImgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numberOfTimesLabel.mas_bottom).with.offset(Height_Pt(33));
        make.left.equalTo(_titleLabel.mas_left);
        make.width.mas_equalTo(Width_Pt(64));
        make.height.mas_equalTo(Height_Pt(44));
    }];
    
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_groupImgview.mas_right).with.offset(10);
        make.centerY.equalTo(_groupImgview);
        make.bottom.equalTo(self).with.offset( - Height_Pt(40));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_peopleLabel.mas_right).with.offset(10);
        make.centerY.equalTo(_groupImgview);
    }];
}

@end
