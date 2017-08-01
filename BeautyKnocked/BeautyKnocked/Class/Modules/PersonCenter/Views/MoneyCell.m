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

-(void)initializeViews {
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(50)];
    _title.textColor=[UIColor blackColor];
    _title.text=@"退款至余额";
    [self.contentView addSubview:_title];
    
    _message=[[UILabel alloc]init];
    _message.font=[UIFont systemFontOfSize:Font_Size(40)];
    _message.textColor=[UIColor lightGrayColor];
    _message.text=@"水漾海洋特润拼团失败";
    [self.contentView addSubview:_message];
    
    _money=[[UILabel alloc]init];
    _money.font=[UIFont systemFontOfSize:Font_Size(50)];
    _money.textAlignment=NSTextAlignmentRight;
    _money.textColor=[UIColor colorWithHexString:@"#D6AA3A"];
    _money.text=@"+1000";
    [self.contentView addSubview:_money];
    
    _time=[[UILabel alloc]init];
    _time.font=[UIFont systemFontOfSize:Font_Size(40)];
    _time.textAlignment=NSTextAlignmentRight;
    _time.textColor=[UIColor lightGrayColor];
    _time.text=@"2017-01-01 01:01";
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
