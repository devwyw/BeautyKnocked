//
//  PayInfoViewCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayInfoViewCell.h"

@interface PayInfoViewCell ()
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UILabel * num;
@property (nonatomic,strong) UILabel * money;
@end

@implementation PayInfoViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(PayInfoModel *)model{
    if ([model.num isEqualToString:@"数量"]) {
        _num.text=model.num;
    }else{
        _num.text=[NSString stringWithFormat:@"x%@",model.num];
    }
    _money.text=model.money;
    if ([model.isUse integerValue]==1) {
        NSString *text=[NSString stringWithFormat:@"%@ (*已优惠)",model.name];
        NSRange colorRang=[text rangeOfString:@"(*已优惠)"];
        NSMutableAttributedString *attText=[[NSMutableAttributedString alloc]initWithString:text];
        [attText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#d72d43"] range:colorRang];
        [attText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(40)] range:NSMakeRange(0, text.length)];
        _name.attributedText=attText;
    }else{
        _name.text=model.name;
    }
}
-(void)initializeViews {
    UIColor *darkGray=[UIColor darkGrayColor];
    UIFont *font=[UIFont systemFontOfSize:Font_Size(40)];
    
    _name=[[UILabel alloc]init];
    _name.font=font;
    _name.textColor=darkGray;
    [self.contentView addSubview:_name];
    
    _num=[[UILabel alloc]init];
    _num.font=font;
    _num.textColor=darkGray;
    [self.contentView addSubview:_num];
    
    _money=[[UILabel alloc]init];
    _money.font=font;
    _money.textColor=darkGray;
    [self.contentView addSubview:_money];
}
-(void)addConstraints {
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(20));
        make.left.equalTo(self.contentView).offset(Width_Pt(50));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
    }];
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_right).offset(-Width_Pt(230));
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
