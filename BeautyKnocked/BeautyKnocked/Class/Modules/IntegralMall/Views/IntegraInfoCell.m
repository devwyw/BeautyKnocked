//
//  IntegraInfoCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegraInfoCell.h"

@interface IntegraInfoCell ()
@property (nonatomic,strong) UILabel * info;
@property (nonatomic,strong) UIView * line;

@property (nonatomic,strong) UILabel * title1;
@property (nonatomic,strong) UILabel * message1;

@property (nonatomic,strong) UILabel * title2;
@property (nonatomic,strong) UILabel * message2;

@property (nonatomic,strong) UILabel * title3;
@property (nonatomic,strong) UILabel * message3;
@end

@implementation IntegraInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=0;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)setModel:(IntegraListModel *)model{
    NSString *text=[model.name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@元",model.price] withString:@""];
    _message1.attributedText=[self getAttributedString:[NSString stringWithFormat:@"优惠券面值：%@元\n类型：%@\n门槛：仅限购买%@时使用\n有效期：领取后即可生效，有效期为一个月",model.price,text,model.productName]];
}

-(void)initializeViews {
    _info=[[UILabel alloc]init];
    _info.font = [UIFont systemFontOfSize:Font_Size(35)];
    _info.textColor=[UIColor darkGrayColor];
    _info.text=@"▸ 详情说明：";
    [self.contentView addSubview:_info];
    
    _line=[Master getLineView:[UIColor colorWithHexString:@"#d3d3d3"]];
    [self.contentView addSubview:_line];
    
    _title1=[[UILabel alloc]init];
    _title1.font = [UIFont boldSystemFontOfSize:Font_Size(45)];
    _title1.text=@"优惠券简介：";
    [self.contentView addSubview:_title1];
    
    _title2=[[UILabel alloc]init];
    _title2.font = [UIFont boldSystemFontOfSize:Font_Size(45)];
    _title2.text=@"兑换流程：";
    [self.contentView addSubview:_title2];
    
    _title3=[[UILabel alloc]init];
    _title3.font = [UIFont boldSystemFontOfSize:Font_Size(45)];
    _title3.text=@"注意事项：";
    [self.contentView addSubview:_title3];
    
    _message1=[[UILabel alloc]init];
    _message1.numberOfLines=0;
    [self.contentView addSubview:_message1];
    
    _message2=[[UILabel alloc]init];
    _message2.numberOfLines=0;
    _message2.attributedText=[self getAttributedString:@"1、点击【立即兑换】按钮，优惠券即时发放到兑换账户，当用户积分小于兑换积分，显示【积分不足】不可兑换；\n2、优惠券信息可在【我的优惠券】中查看；"];
    [self.contentView addSubview:_message2];
    
    _message3=[[UILabel alloc]init];
    _message3.numberOfLines=0;
    _message3.attributedText=[self getAttributedString:@"1、此优惠券仅限兑换用户使用，兑换后不予退还；\n2、如有疑问请拨打热线电话：400-915-8919."];
    [self.contentView addSubview:_message3];
}
-(void)addConstraints {
    [_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Pt(40));
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_info.mas_bottom).offset(Height_Pt(40));
        make.right.equalTo(self.contentView).offset(-Width_Pt(40));
        make.height.offset(Height_Pt(1.5));
    }];
    
    [_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_line.mas_bottom).offset(Height_Pt(45));
    }];
    [_message1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_title1.mas_bottom).offset(Height_Pt(55));
    }];
    
    [_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_message1.mas_bottom).offset(Height_Pt(45));
    }];
    [_message2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.right.equalTo(_line);
        make.top.equalTo(_title2.mas_bottom).offset(Height_Pt(55));
    }];
    
    [_title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_message2.mas_bottom).offset(Height_Pt(45));
    }];
    [_message3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info);
        make.top.equalTo(_title3.mas_bottom).offset(Height_Pt(55));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(40));
    }];
}
-(NSMutableAttributedString*)getAttributedString:(NSString*)string{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, text.length)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment=NSTextAlignmentLeft;
    style.lineSpacing = Height_Pt(20);
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    return text;
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
