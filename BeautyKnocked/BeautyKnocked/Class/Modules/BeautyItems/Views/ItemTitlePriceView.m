//
//  ItemTitlePriceView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemTitlePriceView.h"

@interface ItemTitlePriceView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *alarmImgView;
@property (nonatomic, strong) UILabel *serviceTimeLengthLabel;
@property (nonatomic, strong) UILabel *firstPriceLabel;
@property (nonatomic, strong) UILabel *secondPriceLabel;

@end

@implementation ItemTitlePriceView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _alarmImgView = [[UIImageView alloc] init];
    [_alarmImgView setImage:[UIImage imageNamed:@"fuwushijian"]];
    
    UIFont *textFont = [UIFont systemFontOfSize:Font_Size(38)];
    _serviceTimeLengthLabel = [[UILabel alloc] init];
    _serviceTimeLengthLabel.font = textFont;
    _serviceTimeLengthLabel.textColor = [UIColor lightGrayColor];
    
    _firstPriceLabel = [[UILabel alloc] init];
    _firstPriceLabel.font = textFont;
    _firstPriceLabel.textColor = [UIColor redColor];
    _firstPriceLabel.textAlignment = NSTextAlignmentRight;
    
    _secondPriceLabel = [[UILabel alloc] init];
    _secondPriceLabel.font = textFont;
    _secondPriceLabel.textColor = [UIColor lightGrayColor];
    _secondPriceLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_nameLabel];
    [self addSubview:_alarmImgView];
    [self addSubview:_serviceTimeLengthLabel];
    [self addSubview:_firstPriceLabel];
    [self addSubview:_secondPriceLabel];
    
    _nameLabel.text = @"【水漾海洋特润】";
    _serviceTimeLengthLabel.text = @"服务时长90分钟";
    _firstPriceLabel.text  = @"VIP : ¥ 158";
    _secondPriceLabel.text = @"市场价: ¥ 380";
}

-(void)addConstraints {
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(30));
        make.left.equalTo(self).with.offset(Height_Pt(62));
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_alarmImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(36));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(45), Height_Pt(45)));
    }];
    
    [_serviceTimeLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_alarmImgView);
        make.left.equalTo(_alarmImgView.mas_right).with.offset(5);
    }];
    
    [_firstPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(50));
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.height.mas_equalTo(Height_Pt(38));
    }];
    
    [_secondPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_firstPriceLabel.mas_right);
        make.centerY.equalTo(_serviceTimeLengthLabel);
        make.bottom.equalTo(self).with.offset(- 8);
    }];
}

-(void)setItemName:(NSString *)itemName {
    _nameLabel.text = [NSString stringWithFormat:@"【%@】",itemName];
}
-(void)setServiceTime:(NSString *)serviceTime {
    _serviceTimeLengthLabel.text = [NSString stringWithFormat:@"服务时长%@分钟",serviceTime];
}
-(void)setFirstPrice:(NSString *)firstPrice {
    _firstPriceLabel.text = [NSString stringWithFormat:@"VIP : ¥ %@",firstPrice];
}
-(void)setSecondPrice:(NSString *)secondPrice {
    _firstPriceLabel.text = [NSString stringWithFormat:@"市场价: ¥%@",secondPrice];
}
                             

@end
