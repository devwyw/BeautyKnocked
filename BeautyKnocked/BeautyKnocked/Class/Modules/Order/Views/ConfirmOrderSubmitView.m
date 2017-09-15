//
//  ConfirmOrderSubmitView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderSubmitView.h"

@interface ConfirmOrderSubmitView ()

@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation ConfirmOrderSubmitView

-(void)setTotalPrice:(NSString *)totalPrice {
    _totalPrice = totalPrice;
    if ([totalPrice floatValue]>=1000) {
        totalPrice=[NSString stringWithFormat:@"%.f",[totalPrice floatValue]];
    }else{
        totalPrice=[NSString stringWithFormat:@"%.1f",[totalPrice floatValue]];
    }
    NSString *text = [NSString stringWithFormat:@"总价: ¥ %@",totalPrice];
    NSRange redRange = [text rangeOfString:[text substringFromIndex:4]];
    NSMutableAttributedString *muAttStr = [[NSMutableAttributedString alloc] initWithString:text];
    [muAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    _totalPriceLabel.attributedText = muAttStr;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _totalPriceLabel = [[UILabel alloc] init];
    _totalPriceLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font =  [UIFont systemFontOfSize:Font_Size(50)];
    [_submitBtn setBackgroundColor:ThemeColor];
    
    [self addSubview:_totalPriceLabel];
    [self addSubview:_submitBtn];
    
}
-(void)addConstraints {
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        
    }];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self);
        make.width.mas_equalTo(Width_Pt(320));
    }];
}
-(RACSignal*)payInfo{
    return [_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
