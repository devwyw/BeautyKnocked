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
@property (nonatomic,strong) UIImageView * whiteimage;
@property (nonatomic,strong) UILabel * leftTitle;
@property (nonatomic,strong) UILabel * leftMessage;

@property (nonatomic,strong) UIImageView * backgroundimage;
@property (nonatomic,strong) UIImageView * vipimage;
@property (nonatomic,strong) UIImageView * lineimage;
@property (nonatomic,strong) UILabel * recharge;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * nowRecharge;
@property (nonatomic,strong) UILabel * nowRecharge1;
@property (nonatomic,strong) UIButton * pushBtn;
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
-(void)setModel:(RechargeModel *)model{
    _model=model;
    _vipimage.image=[UIImage imageNamed:[NSString stringWithFormat:@"V%@",model.rank]];
    _money.text=model.money;
    _title.text=[NSString stringWithFormat:@"充值%@，送特权",model.money];
    if (model.isSelected) {
        [_whiteimage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(100);
            make.bottom.equalTo(self.contentView);
        }];
        NSString *discount=[NSString string];
        if ([model.discount integerValue]==1) {
            discount=@"无其它折扣;";
        }else{
            discount=[NSString stringWithFormat:@"预约项目、购买套餐可享受%.1f折;",[model.discount floatValue]*10];
        }
        NSString *title=[NSString stringWithFormat:@"• 折扣: %@",discount];
        NSRange titleR=[title rangeOfString:discount];
        NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
        [titleAtt addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:titleR];
        [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, title.length)];
        _leftTitle.attributedText=titleAtt;
        
        NSString *message=[NSString stringWithFormat:@"• 赠品: %@",model.give];
        NSRange titleM=[message rangeOfString:model.give];
        NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
        [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:titleM];
        [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, message.length)];
        _leftMessage.attributedText=messageAtt;
    }else{
        [_whiteimage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
        }];
        _leftMessage.text=@"";
        _leftTitle.text=@"";
    }
}
-(void)setMyViews{
    _whiteimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangqingbj"]];
    [self.contentView addSubview:_whiteimage];
    
    _leftTitle=[[UILabel alloc]init];
    [_whiteimage addSubview:_leftTitle];
    
    _leftMessage=[[UILabel alloc]init];
    [_whiteimage addSubview:_leftMessage];
    
    _backgroundimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chongzhikabj"]];
    _backgroundimage.userInteractionEnabled=YES;
    [self.contentView addSubview:_backgroundimage];
    
    _vipimage=[[UIImageView alloc]init];
    [_backgroundimage addSubview:_vipimage];
    
    _recharge=[[UILabel alloc]init];
    _recharge.text=@"充值";
    _recharge.font=[UIFont systemFontOfSize:Font_Size(40)];
    _recharge.textColor=[UIColor colorWithHexString:@"#F0B71F"];
    [_backgroundimage addSubview:_recharge];
    
    _money=[[UILabel alloc]init];
    
    _money.font=[UIFont systemFontOfSize:Font_Size(90)];
    _money.textColor=[UIColor colorWithHexString:@"#F1B722"];
    [_backgroundimage addSubview:_money];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_backgroundimage addSubview:_title];
    
    _lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(605), Height_Pt(5))];
    _lineimage.image=[_lineimage drawLineImage:2 withLineHeight:Height_Pt(5) withColor:[UIColor blackColor]];
    [_backgroundimage addSubview:_lineimage];
    
    _message=[[UILabel alloc]init];
    _message.text=@"点击查看充值卡详情";
    _message.font=[UIFont systemFontOfSize:Font_Size(30)];
    _message.textColor=[UIColor colorWithHexString:@"#808080"];
    [_backgroundimage addSubview:_message];
    
    _nowRecharge=[[UILabel alloc]init];
    _nowRecharge.text=@"立即";
    _nowRecharge.font=[UIFont systemFontOfSize:Font_Size(60)];
    _nowRecharge.textColor=[UIColor whiteColor];
    [_backgroundimage addSubview:_nowRecharge];
    
    _nowRecharge1=[[UILabel alloc]init];
    _nowRecharge1.text=@"充值";
    _nowRecharge1.font=[UIFont systemFontOfSize:Font_Size(60)];
    _nowRecharge1.textColor=[UIColor whiteColor];
    [_backgroundimage addSubview:_nowRecharge1];
    
    _pushBtn=[[UIButton alloc]init];
    [_backgroundimage addSubview:_pushBtn];
}
-(void)setMyFrames{
    [_backgroundimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
        make.left.equalTo(self.contentView).offset(Width_Pt(25));
        make.right.equalTo(self.contentView).offset(-Width_Pt(25));
    }];
    
    [_whiteimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0);
        make.top.equalTo(_backgroundimage.mas_bottom).offset(-Height_Pt(20));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
        make.left.right.equalTo(_backgroundimage);
    }];
    [_leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteimage.mas_top).offset(Height_Pt(45));
        make.left.equalTo(_whiteimage).offset(Width_Pt(40));
    }];
    [_leftMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftTitle.mas_bottom).offset(Height_Pt(25));
        make.left.equalTo(_leftTitle);
        make.right.equalTo(_whiteimage).offset(-Width_Pt(50));
    }];
    
    [_vipimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundimage).offset(Height_Pt(35));
        make.left.equalTo(_backgroundimage).offset(Width_Pt(70));
        make.bottom.equalTo(_backgroundimage.mas_centerY).offset(-Height_Pt(10));
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
        make.bottom.equalTo(_backgroundimage.mas_bottom).offset(-Height_Pt(40));
    }];
    
    [_lineimage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage);
        make.bottom.equalTo(_message.mas_top).offset(-Height_Pt(15));
        make.right.equalTo(_backgroundimage).offset(-Width_Pt(340));
        make.height.mas_equalTo(Height_Pt(5));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipimage);
        make.bottom.equalTo(_lineimage.mas_top).offset(-Height_Pt(12));
    }];
    
    [_nowRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backgroundimage).offset(-Width_Pt(75));
        make.bottom.equalTo(_backgroundimage.mas_centerY).offset(-Height_Pt(15));
    }];
    [_nowRecharge1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundimage.mas_centerY).offset(Height_Pt(15));
        make.left.equalTo(_nowRecharge);
    }];
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(_backgroundimage);
        make.left.equalTo(_lineimage.mas_right).offset(Width_Pt(70));
    }];
}
-(RACSignal*)push{
    return [_pushBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
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
