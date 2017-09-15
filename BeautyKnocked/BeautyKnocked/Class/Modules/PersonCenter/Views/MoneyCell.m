//
//  MoneyCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MoneyCell.h"

@interface MoneyCell ()
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * time;
@end

@implementation MoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(MoneyInfoModel *)model{
    _title.text=model.source;
    _message.text=model.name;

    if ([model.status integerValue]==0) {
        _money.textColor=[UIColor colorWithHexString:@"#D6AA3A"];
        _money.text=[NSString stringWithFormat:@"+%@",model.money];
    }else{
        _money.textColor=[UIColor redColor];
        _money.text=[NSString stringWithFormat:@"-%@",model.money];
    }
    
    NSTimeInterval interval=[[model.createDate substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [dateformatter stringFromDate:date];
    _time.text=[NSString stringWithFormat:@"服务时间：%@",timeString];
}
-(void)initializeViews {
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(45)];
    _title.textColor=[UIColor blackColor];
    [self.contentView addSubview:_title];
    
    _message=[[UILabel alloc]init];
    _message.font=[UIFont systemFontOfSize:Font_Size(40)];
    _message.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_message];
    
    _money=[[UILabel alloc]init];
    _money.font=[UIFont systemFontOfSize:Font_Size(50)];
    _money.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_money];
    
    _time=[[UILabel alloc]init];
    _time.font=[UIFont systemFontOfSize:Font_Size(37.5)];
    _time.textAlignment=NSTextAlignmentRight;
    _time.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_time];
}
-(void)addConstraints {
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(50));
        make.left.equalTo(self.contentView).offset(Width_Pt(55));
    }];
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(37));
        make.left.equalTo(_title);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(30));
    }];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title);
        make.right.equalTo(self.contentView).offset(-Width_Pt(55));
    }];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_money.mas_bottom).offset(Height_Pt(37));
        make.right.equalTo(_money);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(30));
    }];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
