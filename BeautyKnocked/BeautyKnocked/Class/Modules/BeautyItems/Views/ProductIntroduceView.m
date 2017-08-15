//
//  ProductIntroduceView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/3.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ProductIntroduceView.h"



@interface ProductIntroduceView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *capacity;
@property (nonatomic, strong) UILabel *origin;
@property (nonatomic, strong) UILabel *shelfLife;
@property (nonatomic, strong) UILabel *effect;

@property (nonatomic, strong) UILabel *capacityLabel;
@property (nonatomic, strong) UILabel *originLabel;
@property (nonatomic, strong) UILabel *shelfLifeLabel;
@property (nonatomic, strong) UILabel *effectLabel;

@end

@implementation ProductIntroduceView

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
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    
    UIFont *font = [UIFont systemFontOfSize:Font_Size(36)];
    _capacity = [[UILabel alloc] init];
    _capacity.font = font;
    _capacity.textColor = [UIColor lightGrayColor];

    _origin = [[UILabel alloc] init];
    _origin.font = font;
    _origin.textColor = [UIColor lightGrayColor];
    
    _shelfLife = [[UILabel alloc] init];
    _shelfLife.font = font;
    _shelfLife.textColor = [UIColor lightGrayColor];

    _effect = [[UILabel alloc] init];
    _effect.font = font;
    _effect.textColor = [UIColor lightGrayColor];
    
    _capacityLabel = [[UILabel alloc] init];
    _capacityLabel.font = font;
    
    _originLabel = [[UILabel alloc] init];
    _originLabel.font = font;
    
    _shelfLifeLabel = [[UILabel alloc] init];
    _shelfLifeLabel.font = font;
    
    _effectLabel = [[UILabel alloc] init];
    _effectLabel.font = font;
    _effectLabel.numberOfLines = 0;
    
    [self addSubview:_titleLabel];
    
    [self addSubview:_line];
    
    [self addSubview:_capacity];
    [self addSubview:_origin];
    [self addSubview:_shelfLife];
    [self addSubview:_effect];
    
    [self addSubview:_capacityLabel];
    [self addSubview:_originLabel];
    [self addSubview:_shelfLifeLabel];
    [self addSubview:_effectLabel];
    
    _titleLabel.text = @"产品介绍";
    _capacity.text = @"容量";
    _origin.text = @"产地";
    _shelfLife.text = @"保质期";
    _effect.text = @"产品功效";
}
-(void)setCapacitys:(NSString *)capacitys{
    _capacityLabel.text = capacitys;
}
-(void)setAddress:(NSString *)address{
    _originLabel.text = address;
}
-(void)setDateLength:(NSString *)dateLength{
    _shelfLifeLabel.text = dateLength;
}
-(void)setEffects:(NSString *)effects{
    _effectLabel.text = effects;
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(30));
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(30));
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.height.mas_equalTo(0.5);
    }];
    
    [_capacity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_line.mas_bottom).with.offset(Height_Pt(28));
        make.height.mas_equalTo(Height_Pt(36));
    }];
    
    [_capacityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(258));
        make.centerY.equalTo(_capacity);
    }];
    
    [_origin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_capacity.mas_bottom).with.offset(Height_Pt(28));
        make.height.mas_equalTo(_capacity.mas_height);
    }];
    
    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_capacityLabel.mas_left);
        make.centerY.equalTo(_origin);
    }];
    
    [_shelfLife mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_origin.mas_bottom).with.offset(Height_Pt(28));
        make.height.mas_equalTo(_capacity.mas_height);
    }];
    
    [_shelfLifeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_capacityLabel.mas_left);
        make.centerY.equalTo(_shelfLife);
    }];
    
    [_effect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_shelfLife.mas_bottom).with.offset(Height_Pt(28));
        make.height.mas_equalTo(_capacity.mas_height);
    }];
    
    [_effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_capacityLabel.mas_left);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.top.equalTo(_effect.mas_top);
        make.bottom.equalTo(self).with.offset( - Height_Pt(28));
    }];

    
}

@end
