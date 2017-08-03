//
//  ItemTitleView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemTitleView.h"

@interface ItemTitleView ()

@property (nonatomic, strong) UIImageView *leftImgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *rightImgView;

@end


@implementation ItemTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createCollectionView];
        [self makeConstraints];
    }
    return self;
}

-(void)createCollectionView {
    
    _leftImgView = [[UIImageView alloc] init];
    [self addSubview:_leftImgView];
    
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    
    _rightImgView = [[UIImageView alloc] init];
    [self addSubview:_rightImgView];
}

-(void)makeConstraints {
    
    CGSize imageSize = CGSizeMake(Width_Pt(36), Width_Pt(36));
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_titleLabel.mas_left).with.offset( - Width_Pt(16));
        make.size.mas_equalTo(imageSize);
    }];
    
    [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).with.offset(Width_Pt(16));
        make.size.mas_equalTo(imageSize);
    }];
    
}

-(void)setTitleName:(NSString *)titleName {
    _titleLabel.text = titleName;
}

-(void)setTitleColor:(UIColor *)titleColor {
    _titleLabel.textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont {
    _titleLabel.font = titleFont;
}

-(void)setLeftImageName:(NSString *)leftImageName {
    [_leftImgView setImage:[UIImage imageNamed:leftImageName]];
}

-(void)setRightImageName:(NSString *)rightImageName {
    [_rightImgView setImage:[UIImage imageNamed:rightImageName]];
}

@end
