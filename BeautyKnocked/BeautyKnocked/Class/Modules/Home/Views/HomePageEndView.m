//
//  HomePageEndView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageEndView.h"

@interface HomePageEndView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;

@end

@implementation HomePageEndView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    
    self.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"end-logo_03"]];
    [self addSubview:_imgView];
    
    _leftLine = [[UIView alloc] init];
    _leftLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_leftLine];
    
    _rightLine = [[UIView alloc] init];
    _rightLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_rightLine];
}

-(void)setupConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(32));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(190), Height_Pt(80)));
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgView);
        make.right.equalTo(_imgView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(200), Height_Pt(1)));
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(200), Height_Pt(1)));
    }];
    
    
}

@end
