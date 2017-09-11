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
-(void)setModel:(IntegraListModel *)model{
    NSString *text=[NSString stringWithFormat:@"¥%@",[model.name stringByReplacingOccurrencesOfString:@"元" withString:@" "]];
    NSString *name=[model.name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@元",model.price] withString:@""];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange minRange = [text rangeOfString:name];
    NSRange maxRange = [text rangeOfString:model.price];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(28)] range:NSMakeRange(0, 1)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(32.5)] range:minRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:Font_Size(50)] range:maxRange];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
    
    _offsetLabel.attributedText = attributeStr;
    _useRangeLabel.text = [NSString stringWithFormat:@"(限购%@)",model.productName];
}
-(void)initializeViews {
    _offsetLabel = [[UILabel alloc] init];
    
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
        make.top.equalTo(self).with.offset(Height_Pt(36));
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
