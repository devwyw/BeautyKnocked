//
//  IntegralBalanceView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegralBalanceView.h"

@interface IntegralBalanceView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@end

@implementation IntegralBalanceView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;

}
-(void)setBablance:(NSString *)bablance {
    _balanceLabel.text = bablance;
}

-(void)initializeViews {
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"jifen"]];
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _nameLabel.text = @"积分";
    
    _balanceLabel = [[UILabel alloc] init];
    _balanceLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _balanceLabel.textColor = [UIColor redColor];
    
    [self addSubview:_imgView];
    [self addSubview:_nameLabel];
    [self addSubview:_balanceLabel];
}
-(void)addConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(50));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(50), Height_Pt(45)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(8);
        make.centerY.equalTo(self);
    }];
    
    [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).with.offset(8);
        make.centerY.equalTo(self);
    }];
}
@end
