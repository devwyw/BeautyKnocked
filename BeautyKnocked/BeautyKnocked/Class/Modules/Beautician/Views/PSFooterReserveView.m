//
//  PSFooterReserveView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PSFooterReserveView.h"

@interface PSFooterReserveView ()

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIButton *reserveNowButton;

@end

@implementation PSFooterReserveView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self createAndAddViews];
        [self addConstraints];
    }
    return self;
}
-(void)setPrice:(NSString *)price{
    _price=price;
    _priceLabel.text = [NSString stringWithFormat:@"合计：¥ %@",price];
}
-(void)setBtnName:(NSString *)btnName{
    [_reserveNowButton setTitle:btnName forState:UIControlStateNormal];
}
-(void)createAndAddViews {
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(47.5)];
    _priceLabel.textColor=ThemeColor;
    _priceLabel.text = @"合计：¥ 0";
    [self addSubview:_priceLabel];
    
    _reserveNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _reserveNowButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_reserveNowButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
    [self addSubview:_reserveNowButton];
}
-(void)addConstraints {
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(60));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(Height_Pt(49));
    }];
    
    [_reserveNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(62));
        make.width.mas_equalTo(Width_Pt(360));
        make.height.mas_equalTo(Height_Pt(100));
    }];
    
}
-(RACSignal*)subPush{
    return [_reserveNowButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
