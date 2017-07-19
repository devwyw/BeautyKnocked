//
//  FeaturedRecommendationsView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FeaturedRecommendationsView.h"
#import "NewPersonView.h"
#import "RecommendBeautyView.h"
#import "ItemTitleView.h"

@interface FeaturedRecommendationsView ()

@property (nonatomic, strong) ItemTitleView *titleView;

@property (nonatomic, strong) NewPersonView *lotteryView;

@property (nonatomic, strong) NewPersonView *productMallView;

@property (nonatomic, strong) RecommendBeautyView *goldBeautyView;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UIView *line2;

@end

@implementation FeaturedRecommendationsView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
        [self configureConstraints];
    }
    return self;
}

-(void)createInterface {
    _titleView = [[ItemTitleView alloc] init];
    _titleView.titleName = @"精选推荐";
    _titleView.leftImageName = @"tuijian_03";
    _titleView.titleFont = [UIFont systemFontOfSize:Font_Size(38)];
    [self addSubview:_titleView];
    
    _lotteryView = [[NewPersonView alloc] init];
    _lotteryView.titleFont = [UIFont systemFontOfSize:Font_Size(38)];
    _lotteryView.descrFont = [UIFont systemFontOfSize:Font_Size(32)];
    _lotteryView.title = @"新人领券";
    _lotteryView.descr = @"即领即用,领券更实惠";
    _lotteryView.image = [UIImage imageNamed:@"xinrenlingquan_03"];
    _lotteryView.imageSize = CGSizeMake(Width_Pt(175), Height_Pt(117));
    [_lotteryView.button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [_lotteryView.button setTag:1];
    [self addSubview:_lotteryView];
    
    _productMallView = [[NewPersonView alloc] init];
    _productMallView.titleFont = [UIFont systemFontOfSize:Font_Size(38)];
    _productMallView.descrFont = [UIFont systemFontOfSize:Font_Size(32)];
    _productMallView.title = @"产品商城";
    _productMallView.descr = @"大牌尖货通通等你来抢";
    _productMallView.image = [UIImage imageNamed:@"chanpinshangcheng_03"];
    _productMallView.imageSize = CGSizeMake(Width_Pt(123), Height_Pt(140));
    [_productMallView.button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [_productMallView.button setTag:2];
    [self addSubview:_productMallView];
    
    _goldBeautyView = [[RecommendBeautyView alloc] init];
    [self addSubview:_goldBeautyView];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line1];
    
    _line2 = [[UIView alloc] init];
    _line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line2];
}
-(void)button:(UIButton*)button{
    [_viewDelegate buttonMore:button];
}
-(void)configureConstraints {
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(Width_Pt(200));
        make.height.mas_equalTo(Height_Pt(80));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [_goldBeautyView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom);
        make.left.and.bottom.equalTo(self);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom);
        make.left.equalTo(_goldBeautyView.mas_right);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
    
    [_lotteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom);
        make.left.equalTo(_line1.mas_right);
        make.right.equalTo(self);
        make.width.equalTo(_goldBeautyView);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lotteryView.mas_bottom);
        make.left.equalTo(_line1.mas_right);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [_productMallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line1.mas_right);
        make.top.equalTo(_line2.mas_bottom);
        make.right.and.bottom.equalTo(self);
        make.height.equalTo(_lotteryView);
    }];
}
@end
