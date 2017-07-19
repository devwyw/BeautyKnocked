//
//  FilterCollectionReusableHeaderView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FilterCollectionReusableHeaderView.h"

@interface FilterCollectionReusableHeaderView ()

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation FilterCollectionReusableHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createControls];
        [self addConstraints];
        
    }
    return self;
}

-(void)createControls {
    
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_leftView];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [self addSubview:_textLabel];
}

-(void)addConstraints {
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(Width_Pt(10));
        make.height.mas_equalTo(Height_Pt(34));
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_leftView.mas_right).with.offset(Width_Pt(20));
    }];
}

-(void)setTitle:(NSString *)title {
    _textLabel.text = title;
}

@end
