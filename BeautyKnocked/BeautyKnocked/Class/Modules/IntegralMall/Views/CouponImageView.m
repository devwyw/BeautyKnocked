//
//  CouponImageView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponImageView.h"

@interface CouponImageView ()
@property (nonatomic, strong) UILabel *offsetLabel;
@property (nonatomic, strong) UIImageView *appointNowImgView;
@property (nonatomic, strong) UILabel *useRangeLabel;
@end

@implementation CouponImageView

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
    
    _appointNowImgView = [[UIImageView alloc] init];
    [_appointNowImgView setImage:[UIImage imageNamed:@"lijiduihuan"]];
    
    _useRangeLabel = [[UILabel alloc] init];
    _useRangeLabel.font = [UIFont systemFontOfSize:Font_Size(26)];
    _useRangeLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_offsetLabel];
    [self addSubview:_appointNowImgView];
    [self addSubview:_useRangeLabel];

}
-(void)addConstraints {
    [_offsetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(40));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_appointNowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_offsetLabel.mas_bottom).with.offset(Height_Pt(8));
        make.height.mas_equalTo(Height_Pt(45));
        make.width.mas_equalTo(Height_Pt(184));
    }];
    
    [_useRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_appointNowImgView.mas_bottom).with.offset(Height_Pt(8));
        make.height.mas_equalTo(Height_Pt(28));
    }];

}
@end
