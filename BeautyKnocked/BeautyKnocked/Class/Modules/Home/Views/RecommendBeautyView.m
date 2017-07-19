//
//  RecommendBeautyView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RecommendBeautyView.h"

@interface RecommendBeautyView ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *flowerBasketsImgView;

@property (nonatomic, strong) UIImageView *beautyImgView;

@property (nonatomic, strong) UIImageView *optimalImgView;

@property (nonatomic, strong) UIView *starRateview;

@end

@implementation RecommendBeautyView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
        [self configureConstraints];
    }
    return self;
}
-(void)createInterface {
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = @"推荐技师";
    _textLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    [self addSubview:_textLabel];
    
    _flowerBasketsImgView = [[UIImageView alloc] init];
    [_flowerBasketsImgView setImage:[UIImage imageNamed:@"huaquan_03"]];
    [self addSubview:_flowerBasketsImgView];
    
    _beautyImgView = [[UIImageView alloc] init];
    [_beautyImgView setImage:[UIImage imageNamed:@"meirongshi_03"]];
    [_flowerBasketsImgView addSubview:_beautyImgView];
    
    _optimalImgView = [[UIImageView alloc] init];
    [_optimalImgView setImage:[UIImage imageNamed:@"jinpaijishi_03 (2)"]];
    [_flowerBasketsImgView addSubview:_optimalImgView];
    
    _starRateview = [[UIView alloc] init];
    [self addSubview:_starRateview];
    
}

-(void)configureConstraints {
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(12));
        make.top.equalTo(self).with.offset(Height_Pt(15));
        make.height.mas_equalTo(Height_Pt(46));
    }];
    
    [_flowerBasketsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(28));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(248), Height_Pt(235)));
    }];
    
    [_beautyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_flowerBasketsImgView).with.offset(Height_Pt(34));
        make.centerX.equalTo(_flowerBasketsImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(178), Height_Pt(176)));
    }];
    
    [_optimalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beautyImgView.mas_bottom).with.offset( - Height_Pt(8));
        make.centerX.equalTo(_flowerBasketsImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(142), Height_Pt(30)));
    }];
    
    [_starRateview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_flowerBasketsImgView.mas_bottom).with.offset(Height_Pt(10));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(162), Height_Pt(32)));
    }];
    for (int i = 0; i < 5; i++){
        UIImageView *image= [[UIImageView alloc] initWithFrame:CGRectMake((Width_Pt(162)/5)*i, 0,Width_Pt(162)/5,Height_Pt(32))];
        [image setImage:[UIImage imageNamed:@"xing_03"]];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        [_starRateview addSubview:image];
    }
}

@end
