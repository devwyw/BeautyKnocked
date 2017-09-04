//
//  CouponCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponCell.h"
#import "NSString+Attribute.h"

@interface CouponCell ()
@property (nonatomic,strong) UIImageView * whiteImage;
@property (nonatomic,strong) UILabel * label1;
@property (nonatomic,strong) UILabel * label2;
@property (nonatomic,strong) UILabel * label3;
@property (nonatomic,strong) UILabel * label4;
@property (nonatomic,strong) UIButton * nowPay;

@property (nonatomic,strong) UIImageView * backImage;
@property (nonatomic,strong) UIImageView * leftImage;
@property (nonatomic,strong) UIImageView * rightImage;
@property (nonatomic,strong) UILabel * type;

@property (nonatomic,strong) UIView * centerview;
@property (nonatomic,strong) UILabel * money;

@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * time;
@end

@implementation CouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(CouponModel *)model{
    _model=model;
    if (isStringEmpty(model.status)) {
        _backImage.image=[UIImage imageNamed:@"youhuiquan-keyong"];
    }else{
        switch ([model.status integerValue]) {
                case 0:
                _backImage.image=[UIImage imageNamed:@"youhuiquan-keyong"];
                break;
                case 1:
                _backImage.image=[UIImage imageNamed:@"youhuiquan-keyong"];
                _rightImage.image=[UIImage imageNamed:@"yishiyong"];
                break;
            default:
                _backImage.image=[UIImage imageNamed:@"youhuiquan-bukeyong"];
                _rightImage.image=[UIImage imageNamed:@"yiguoqi"];
                break;
        }
    }
    _title.text=model.name;
    _type.text=model.type;
    NSString *text=[NSString stringWithFormat:@"¥ %@",model.money];
    _money.attributedText=[text setMinString:@"¥" withMinFont:Font_Size(50) andMaxString:model.money withMaxFont:Font_Size(100)];
    
    _message.text=[NSString stringWithFormat:@"• %@",model.commName];
    _time.text=[NSString stringWithFormat:@"有效期: %@-%@",[self getWebTime:model.startTime],[self getWebTime:model.endTime]];
    
    if (model.isStatus) {
        if (isStringEmpty(model.status)||[model.status integerValue]==0) {
            [_whiteImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(175);
            }];
            _nowPay.hidden=NO;
        }else{
            [_whiteImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(175-Height_Pt(120));
            }];
            _nowPay.hidden=YES;
        }
        NSString *type=nil;
        switch ([model.type integerValue]) {
            case 1:
                type=@"项目";
                break;
            case 2:
                type=@"项目现金抵用券";
                break;
            case 4:
                type=@"闺蜜券";
                break;
            case 5:
                type=@"产品";
                break;
            case 6:
                type=@"产品现金抵用券";
                break;
            default:
                break;
        }
        _label1.text=[NSString stringWithFormat:@"• 此优惠券为%@;",type];
        _label2.text=[NSString stringWithFormat:@"• 此优惠券面值%@元，可抵扣相同金额的价格;",model.money];
        _label3.text=@"• 每笔订单最多限用一张，不叠加使用优惠券;";
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"• 券不找零，不兑换现金，最终解释权归美丽敲敲门所有;"];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, attributeStr.length)];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment=NSTextAlignmentLeft;
        style.headIndent = Font_Size(30);
        style.lineSpacing=5;
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributeStr.length)];
        _label4.attributedText=attributeStr;
    }else{
        [_whiteImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        _label1.text=nil;
        _label2.text=nil;
        _label3.text=nil;
        _label4.text=nil;
        _nowPay.hidden=YES;
    }
}
-(NSString*)getWebTime:(NSString*)time{
    NSTimeInterval interval=[[time substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy.MM.dd"];
    NSString *timeString = [dateformatter stringFromDate:date];
    return timeString;
}
-(void)initializeViews {
    _backImage=[[UIImageView alloc]init];
    [self.contentView addSubview:_backImage];
    
    _whiteImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhankaibeijing"]];
    _whiteImage.userInteractionEnabled=YES;
    [self.contentView addSubview:_whiteImage];
    
    UIColor *gray=[UIColor darkGrayColor];
    UIFont *font=[UIFont systemFontOfSize:Font_Size(35)];
    
    _label1=[[UILabel alloc]init];
    _label1.textColor=gray;
    _label1.font=font;
    [_whiteImage addSubview:_label1];
    
    _label2=[[UILabel alloc]init];
    _label2.textColor=gray;
    _label2.font=font;
    [_whiteImage addSubview:_label2];
    
    _label3=[[UILabel alloc]init];
    _label3.textColor=gray;
    _label3.font=font;
    [_whiteImage addSubview:_label3];
    
    _label4=[[UILabel alloc]init];
    _label4.textColor=gray;
    _label4.font=font;
    _label4.numberOfLines=2;
    [_whiteImage addSubview:_label4];
    
    _nowPay=[[UIButton alloc]init];
    [_nowPay setTitle:@"立即使用" forState:UIControlStateNormal];
    [_nowPay setBackgroundImage:[UIImage imageNamed:@"lijishiyong"] forState:UIControlStateNormal];
    _nowPay.titleLabel.font=font;
    [_whiteImage addSubview:_nowPay];
    
    _leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaoqian"]];
    [_backImage addSubview:_leftImage];

    _type=[[UILabel alloc]init];
    _type.font=[UIFont systemFontOfSize:Font_Size(20)];
    _type.textAlignment=NSTextAlignmentCenter;
    _type.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [_leftImage addSubview:_type];
    
    _centerview=[[UIView alloc]init];
    [_backImage addSubview:_centerview];
    
    _money=[[UILabel alloc]init];
    _money.textColor=[UIColor whiteColor];
    [_centerview addSubview:_money];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont boldSystemFontOfSize:Font_Size(50)];
    [_backImage addSubview:_title];
    
    _message=[[UILabel alloc]init];
    _message.textColor=[UIColor darkGrayColor];
    _message.font=[UIFont systemFontOfSize:Font_Size(37.5)];
    [_backImage addSubview:_message];
    
    _time=[[UILabel alloc]init];
    _time.textColor=[UIColor darkGrayColor];
    _time.font=[UIFont systemFontOfSize:Font_Size(32.5)];
    [_backImage addSubview:_time];
    
    _rightImage=[[UIImageView alloc]init];
    [_backImage addSubview:_rightImage];
}
-(void)addConstraints {
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
        make.left.equalTo(self.contentView).offset(Width_Pt(60));
        make.right.equalTo(self.contentView).offset(-Width_Pt(60));
        make.height.offset(Height_Pt(300));
    }];
    
    [_whiteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImage.mas_bottom).offset(-1);
        make.left.right.equalTo(_backImage);
        make.bottom.equalTo(self.contentView);
        make.height.offset(0);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteImage).offset(Height_Pt(30));
        make.left.equalTo(_whiteImage).offset(Width_Pt(40));
        make.right.equalTo(_whiteImage).offset(-Width_Pt(50));
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).offset(Height_Pt(25));
        make.left.right.equalTo(_label1);
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).offset(Height_Pt(25));
        make.left.right.equalTo(_label2);
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label3.mas_bottom).offset(Height_Pt(25));
        make.left.right.equalTo(_label3);
    }];
    
    [_nowPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_whiteImage);
        make.bottom.equalTo(_whiteImage).offset(-Height_Pt(40));
        make.size.sizeOffset(CGSizeMake(Width_Pt(220), Height_Pt(80)));
    }];
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImage).offset(-1);
        make.left.equalTo(_backImage);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(105), Height_Pt(105)));
    }];
    [_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImage.mas_top).offset(Height_Pt(40));
        make.centerX.equalTo(_leftImage.mas_left).offset(Width_Pt(40));
    }];
    
    [_centerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_backImage);
        make.right.equalTo(_title.mas_left).offset(-Width_Pt(30));
    }];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_centerview);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImage).offset(Height_Pt(40));
        make.left.equalTo(_backImage).offset(Width_Pt(400));
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(_title);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message.mas_bottom).offset(Height_Pt(30));
        make.left.equalTo(_title);
    }];

    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImage).offset(Height_Pt(20));
        make.right.equalTo(_backImage).offset(-Width_Pt(15));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(200), Height_Pt(105)));
    }];
}
-(RACSignal*)useCoupon{
    return [_nowPay rac_signalForControlEvents:UIControlEventTouchUpInside];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
