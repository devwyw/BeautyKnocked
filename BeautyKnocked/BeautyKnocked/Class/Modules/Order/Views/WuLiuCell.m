//
//  WuLiuCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "WuLiuCell.h"

@interface WuLiuCell ()

@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UIView * point;
@property (nonatomic,strong) UILabel * label1;
@property (nonatomic,strong) UILabel * label2;

@end

@implementation WuLiuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_line];
    
    _point=[[UIView alloc]init];
    _point.backgroundColor=[UIColor colorWithHexString:@"#DFA518"];
    [self.contentView addSubview:_point];
    
    _label1=[[UILabel alloc]init];
    _label1.font=[UIFont systemFontOfSize:Font_Size(38)];
    _label1.numberOfLines=0;
    _label1.text=@"【南昌市】已提货 收件人：刘亦菲 顺丰快递 派出所爸爸把啊啊吧 派件中 派件员：傻哈哈 12345678912";
    [self.contentView addSubview:_label1];
    
    _label2=[[UILabel alloc]init];
    _label2.font=[UIFont systemFontOfSize:Font_Size(34)];
    _label2.textColor=[UIColor grayColor];
    _label2.text=@"2017-01-01 01:01";
    [self.contentView addSubview:_label2];
}
-(void)addConstraints {
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(Width_Pt(72));
        make.width.mas_equalTo(1);
    }];
    [_point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line);
        make.centerX.equalTo(_line);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(25), Width_Pt(25)));
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(_line.mas_right).offset(Width_Pt(60));
        make.right.equalTo(self.contentView).offset(-Width_Pt(50));
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).offset(Height_Pt(30));
        make.left.equalTo(_label1);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    _point.layer.cornerRadius=_point.frame.size.width/2;
    _point.layer.masksToBounds=YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end