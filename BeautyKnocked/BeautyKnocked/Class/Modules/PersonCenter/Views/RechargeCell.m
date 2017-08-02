//
//  RechargeCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeCell.h"
#import "UIImageView+Category.h"

@interface RechargeCell ()
@property (nonatomic,strong) UIImageView * backimage;
@property (nonatomic,strong) UIImageView * vipimage;
@property (nonatomic,strong) UIImageView * lineimage;
@property (nonatomic,strong) UILabel * recharge;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * nowRecharge;
@property (nonatomic,strong) UILabel * nowRecharge1;
@end

@implementation RechargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setMyViews];
        [self setMyFrames];
    }
    return self;
}
-(void)setMyViews{
    _backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chongzhikabj"]];
    [self.contentView addSubview:_backimage];
    
    _vipimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"V1"]];
    [_backimage addSubview:_vipimage];
    
    _recharge=[[UILabel alloc]init];
    _recharge.text=@"充值";
    _recharge.font=[UIFont systemFontOfSize:Font_Size(40)];
    _recharge.textColor=[UIColor colorWithHexString:@"#F0B71F"];
    [_backimage addSubview:_recharge];
    
    _money=[[UILabel alloc]init];
    _money.text=@"1000";
    _money.font=[UIFont systemFontOfSize:Font_Size(90)];
    _money.textColor=[UIColor colorWithHexString:@"#F1B722"];
    [_backimage addSubview:_money];
    
    _title=[[UILabel alloc]init];
    _title.text=@"充值1000，送特权";
    _title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_backimage addSubview:_title];
    
    _lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(605), Height_Pt(5))];
    _lineimage.image=[_lineimage drawLineImage:2 withLineHeight:Height_Pt(5) withColor:[UIColor blackColor]];
    [_backimage addSubview:_lineimage];
    
    _message=[[UILabel alloc]init];
    _message.text=@"点击查看充值卡详情";
    _message.font=[UIFont systemFontOfSize:Font_Size(30)];
    _message.textColor=[UIColor colorWithHexString:@"#808080"];
    [_backimage addSubview:_message];
    
    _nowRecharge=[[UILabel alloc]init];
    _nowRecharge.text=@"立即";
    _nowRecharge.font=[UIFont systemFontOfSize:Font_Size(60)];
    _nowRecharge.textColor=[UIColor whiteColor];
    [_backimage addSubview:_nowRecharge];
    _nowRecharge1=[[UILabel alloc]init];
    _nowRecharge1.text=@"充值";
    _nowRecharge1.font=[UIFont systemFontOfSize:Font_Size(60)];
    _nowRecharge1.textColor=[UIColor whiteColor];
    [_backimage addSubview:_nowRecharge1];
}
-(void)setMyFrames{
    [_backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(Width_Pt(25));
        make.right.equalTo(self.contentView).offset(-Width_Pt(25));
    }];
    
    [_vipimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backimage).offset(Height_Pt(35));
        make.left.equalTo(_backimage).offset(Width_Pt(70));
        make.bottom.equalTo(_backimage.mas_centerY).offset(-Height_Pt(10));
        make.width.mas_equalTo(Width_Pt(115));
    }];

    [_recharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage.mas_right).offset(Width_Pt(22));
        make.bottom.equalTo(_vipimage.mas_bottom);
    }];
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recharge.mas_right).offset(Width_Pt(22));
        make.bottom.equalTo(_recharge.mas_bottom).offset(Height_Pt(15));
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage);
        make.bottom.equalTo(_backimage.mas_bottom).offset(-Height_Pt(40));
    }];
    
    [_lineimage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage);
        make.bottom.equalTo(_message.mas_top).offset(-Height_Pt(15));
        make.right.equalTo(_backimage).offset(-Width_Pt(340));
        make.height.mas_equalTo(Height_Pt(5));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage);
        make.bottom.equalTo(_lineimage.mas_top).offset(-Height_Pt(12));
    }];
    
    [_nowRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backimage).offset(-Width_Pt(75));
        make.bottom.equalTo(_backimage.mas_centerY).offset(-Height_Pt(15));
    }];
    [_nowRecharge1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backimage.mas_centerY).offset(Height_Pt(15));
        make.left.equalTo(_nowRecharge);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
