//
//  PayInfoCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayInfoCell.h"

@interface PayInfoCell ()
@property (nonatomic,strong) UILabel * rank;
@property (nonatomic,strong) UILabel * money;

@property (nonatomic,strong) UILabel * messageLabel;
@property (nonatomic,strong) UILabel * message1;
@property (nonatomic,strong) UILabel * message2;
@property (nonatomic,strong) UILabel * message3;

@property (nonatomic,strong) UILabel * useLabel;
@property (nonatomic,strong) UILabel * use1;
@property (nonatomic,strong) UILabel * use2;
@property (nonatomic,strong) UILabel * use3;
@end

@implementation PayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _rank=[[UILabel alloc]init];
    _rank.font=[UIFont systemFontOfSize:Font_Size(50)];
    _rank.textColor=[UIColor colorWithHexString:@"#DCB672"];
    [self.contentView addSubview:_rank];
    
    _money=[[UILabel alloc]init];
    _money.font=[UIFont systemFontOfSize:Font_Size(100)];
    _money.textColor=[UIColor colorWithHexString:@"#DAB770"];
    [self.contentView addSubview:_money];
    
    _messageLabel=[[UILabel alloc]init];
    _messageLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_messageLabel];
    
    _message1=[[UILabel alloc]init];
    _message1.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_message1];
    
    _message2=[[UILabel alloc]init];
    _message2.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_message2];
    
    _message3=[[UILabel alloc]init];
    _message3.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_message3];
    
    _useLabel=[[UILabel alloc]init];
    _useLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_useLabel];
    
    _use1=[[UILabel alloc]init];
    _use1.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_use1];
    
    _use2=[[UILabel alloc]init];
    _use2.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_use2];
    
    _use3=[[UILabel alloc]init];
    _use3.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_use3];
    
    {
        _rank.text=@"V1会员卡";
        _money.text=@"¥ 1000";
        _message2.text=@"• 无其它折扣;";
        _message3.text=@"• 充值即送: 价值98元的胎盘酶青春活研修复面膜一盒";
        
        _messageLabel.text=@"充值介绍:";
        _useLabel.text=@"使用说明:";
        _message1.text=@"• 可以享受项目的VIP体验价;";
        _use1.text=@"• 本卡无价格门槛使用";
        _use2.text=@"• 本卡不在产品商城、组合商城内使用";
        _use3.text=@"• 客服热线: 400-915-8919";
    }
}
-(void)addConstraints {
    [_rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Pt(45));
        make.bottom.equalTo(_money).offset(-Height_Pt(15));
    }];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(95));
        make.left.equalTo(_rank.mas_right).offset(Width_Pt(80));
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rank.mas_bottom).offset(Height_Pt(90));
        make.left.equalTo(_rank);
    }];
    [_message1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_messageLabel.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_messageLabel).offset(Width_Pt(10));
    }];
    [_message2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message1.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_message1);
    }];
    [_message3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message2.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_message2);
    }];
    
    [_useLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message3.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(_messageLabel);
    }];
    [_use1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_useLabel.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_useLabel).offset(Width_Pt(10));
    }];
    [_use2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_use1.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_use1);
    }];
    [_use3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_use2.mas_bottom).offset(Height_Pt(15));
        make.left.equalTo(_use2);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(40));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
