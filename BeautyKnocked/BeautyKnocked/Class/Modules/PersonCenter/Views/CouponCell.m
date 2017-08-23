//
//  CouponCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponCell.h"
#import "CouponModel.h"

@interface CouponCell ()
@property (nonatomic,strong) UIImageView * backImage;
@property (nonatomic,strong) UIImageView * leftImage;
@property (nonatomic,strong) UIImageView * rightImage;
@property (nonatomic,strong) UILabel * type;

@property (nonatomic,strong) UIView * centerview;
@property (nonatomic,strong) UILabel * RMB;
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
    _title.text=model.name;
    _type.text=model.type;
    _money.text=model.money;
    _message.text=[NSString stringWithFormat:@"• %@",model.commName];
    _time.text=[NSString stringWithFormat:@"有效期: %@-%@",[self getWebTime:model.startTime],[self getWebTime:model.endTime]];
    
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
    
    _leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaoqian"]];
    [_backImage addSubview:_leftImage];

    _type=[[UILabel alloc]init];
    _type.font=[UIFont systemFontOfSize:Font_Size(20)];
    _type.textAlignment=NSTextAlignmentCenter;
    _type.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [_leftImage addSubview:_type];
    
    _centerview=[[UIView alloc]init];
    [_backImage addSubview:_centerview];
    
    _RMB=[[UILabel alloc]init];
    _RMB.font=[UIFont systemFontOfSize:Font_Size(50)];
    _RMB.textColor=[UIColor whiteColor];
    _RMB.text=@"¥";
    [_centerview addSubview:_RMB];
    
    _money=[[UILabel alloc]init];
    _money.font=[UIFont boldSystemFontOfSize:Font_Size(100)];
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
        make.left.equalTo(self.contentView).offset(Width_Pt(40));
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-Width_Pt(40));
        make.height.mas_equalTo(Height_Pt(300));
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
    [_RMB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_money.mas_bottom).offset(-Height_Pt(15));
        make.right.equalTo(_money.mas_left).offset(-Width_Pt(10));
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
