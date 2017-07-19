//
//  ExchangeDetailCouponImage.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeDetailCouponImage.h"

@interface ExchangeDetailCouponImage ()
@property (nonatomic, strong) UILabel *offsetLabel;
@property (nonatomic, strong) UILabel *useRangeLabel;
@end
@implementation ExchangeDetailCouponImage

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)setOffset:(NSString *)offset {
    _offsetLabel.text = [NSString stringWithFormat:@"¥%@ 优惠券",offset];
}

-(void)setProductName:(NSString *)productName {
    _useRangeLabel.text = [NSString stringWithFormat:@"限购%@",productName];
}

-(void)initializeViews {
    _offsetLabel = [[UILabel alloc] init];
    _offsetLabel.textColor = [UIColor whiteColor];
    
    _useRangeLabel = [[UILabel alloc] init];
    _useRangeLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    _useRangeLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_offsetLabel];
    [self addSubview:_useRangeLabel];
    
}
-(void)addConstraints {
    
    [_offsetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(70));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(Height_Pt(65));
    }];
    
    [_useRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_offsetLabel.mas_bottom).with.offset(Height_Pt(30));
        make.height.mas_equalTo(Height_Pt(36));
    }];
    
}


@end
