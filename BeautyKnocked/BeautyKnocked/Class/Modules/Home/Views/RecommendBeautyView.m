//
//  RecommendBeautyView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RecommendBeautyView.h"
#import "StarView.h"
#import "BeauticianModel.h"

@interface RecommendBeautyView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *flowerBasketsImgView;
@property (nonatomic, strong) UIImageView *beautyImgView;
@property (nonatomic, strong) UIImageView *optimalImgView;
@property (nonatomic, strong) StarView *starRateview;
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
-(void)setModel:(BeauticianModel *)model{
    _model=model;
    [Master GetWebImage:_beautyImgView withUrl:model.headPath];
    if (!isStringEmpty(model.score)) {
        _starRateview.starCount=[model.score integerValue];
    }
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
    [_beautyImgView makeCornerRadius:Width_Pt(175)/2];
    [_flowerBasketsImgView addSubview:_beautyImgView];
    
    _optimalImgView = [[UIImageView alloc] init];
    [_optimalImgView setImage:[UIImage imageNamed:@"jinpaijishi_03 (2)"]];
    [_flowerBasketsImgView addSubview:_optimalImgView];
    
    _starRateview = [StarView evaluationViewWithChooseStarBlock:nil];
    _starRateview.spacing=0.1;
    _starRateview.tapEnabled=NO;
    [self addSubview:_starRateview];
    
    _button=[[UIButton alloc]init];
    [self addSubview:_button];
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
        make.top.equalTo(_flowerBasketsImgView).with.offset(Height_Pt(33.5));
        make.centerX.equalTo(_flowerBasketsImgView).offset(-2.2);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(175), Height_Pt(175)));
    }];
    
    [_optimalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beautyImgView.mas_bottom).with.offset( - Height_Pt(8));
        make.centerX.equalTo(_flowerBasketsImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(142), Height_Pt(30)));
    }];
    
    [_starRateview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_flowerBasketsImgView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(Width_Pt(200));
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
