//
//  FightGroupPeopleView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupPeopleView.h"

@interface FightGroupPeopleView ()

@property (nonatomic, strong) UIImageView *headImg0;
@property (nonatomic, strong) UIImageView *headImg1;
@property (nonatomic, strong) UIImageView *headImg2;
@property (nonatomic, strong) UIImageView *headImg3;
@property (nonatomic, strong) UIImageView *headImg4;

@end

@implementation FightGroupPeopleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _headImg0 = [[UIImageView alloc] init];
    _headImg1 = [[UIImageView alloc] init];
    _headImg2 = [[UIImageView alloc] init];
    _headImg3 = [[UIImageView alloc] init];
    _headImg4 = [[UIImageView alloc] init];
    
    [_headImg0 setImage:[UIImage imageNamed:@"weizhi"]];
    [_headImg1 setImage:[UIImage imageNamed:@"weizhi"]];
    [_headImg2 setImage:[UIImage imageNamed:@"weizhi"]];
    [_headImg3 setImage:[UIImage imageNamed:@"weizhi"]];
    [_headImg4 setImage:[UIImage imageNamed:@"weizhi"]];
    
    [self addSubview:_headImg0];
    [self addSubview:_headImg1];
    [self addSubview:_headImg2];
    [self addSubview:_headImg3];
    [self addSubview:_headImg4];
}
-(void)addConstraints {
    
    NSArray *views = @[_headImg0,_headImg1,_headImg2,_headImg3,_headImg4];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(Height_Pt(120));
    }];
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:Width_Pt(120) leadSpacing:Width_Pt(155) tailSpacing:Width_Pt(155)];
    
}

@end
