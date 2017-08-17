//
//  CouponCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()
@property (nonatomic,strong) UIImageView * backImage;
@property (nonatomic,strong) UIImageView * leftImage;
@property (nonatomic,strong) UIImageView * rightImage;
@property (nonatomic,strong) UILabel * type;
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
-(void)initializeViews {
    _backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youhuiquan-keyong"]];
    [self.contentView addSubview:_backImage];
    
    _leftImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"biaoqian"]];
    [_backImage addSubview:_leftImage];

    _type=[[UILabel alloc]init];
    _type.font=[UIFont systemFontOfSize:Font_Size(20)];
    _type.text=@"积分兑换";
    _type.textAlignment=NSTextAlignmentCenter;
    _type.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [_leftImage addSubview:_type];
    
    _RMB=[[UILabel alloc]init];
    _RMB.font=[UIFont systemFontOfSize:Font_Size(50)];
    _RMB.textColor=[UIColor whiteColor];
    _RMB.text=@"¥";
    [_backImage addSubview:_RMB];
    
    _money=[[UILabel alloc]init];
    _money.font=[UIFont boldSystemFontOfSize:Font_Size(100)];
    _money.textColor=[UIColor whiteColor];
    _money.text=@"88";
    [_backImage addSubview:_money];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont boldSystemFontOfSize:Font_Size(45)];
    _title.text=@"指定项目红包券";
    [_backImage addSubview:_title];
    
    _message=[[UILabel alloc]init];
    _message.textColor=[UIColor darkGrayColor];
    _message.font=[UIFont systemFontOfSize:Font_Size(37.5)];
    _message.text=@"• 仅限抵用水美人护理项目";
    [_backImage addSubview:_message];
    
    _time=[[UILabel alloc]init];
    _time.textColor=[UIColor darkGrayColor];
    _time.font=[UIFont systemFontOfSize:Font_Size(32.5)];
    _time.text=@"有效期: 2017.01.01-2017.01.01";
    [_backImage addSubview:_time];
    
    _rightImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yishiyong"]];
    [_backImage addSubview:_rightImage];
}
-(void)addConstraints {
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
        make.left.equalTo(self.contentView).offset(Width_Pt(77));
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-Width_Pt(70));
        make.height.mas_equalTo(Height_Pt(255));
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
    
    [_RMB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImage).offset(Width_Pt(80));
        make.bottom.equalTo(_money.mas_bottom).offset(-Height_Pt(15));
    }];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_RMB.mas_right).offset(Width_Pt(15));
        make.centerY.equalTo(_backImage);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImage).offset(Height_Pt(40));
        make.left.equalTo(_backImage).offset(Width_Pt(385));
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(35));
        make.left.equalTo(_title);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message.mas_bottom).offset(Height_Pt(15));
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
