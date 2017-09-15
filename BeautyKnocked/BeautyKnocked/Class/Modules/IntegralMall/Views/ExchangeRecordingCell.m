//
//  ExchangeRecordingCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeRecordingCell.h"

@interface ExchangeRecordingCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * info;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ExchangeRecordingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(IntegraListModel *)model{
    NSString *text=[NSString stringWithFormat:@"¥%@",[model.name stringByReplacingOccurrencesOfString:@"元" withString:@" "]];
    NSString *name=[model.name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@元",model.price] withString:@""];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange minRange = [text rangeOfString:name];
    NSRange maxRange = [text rangeOfString:model.price];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(32.5)] range:NSMakeRange(0, 1)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35.5)] range:minRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:Font_Size(55)] range:maxRange];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#feffe8"] range:NSMakeRange(0, text.length)];
    
    _title.attributedText = attributeStr;
    _info.text = [NSString stringWithFormat:@"(限购%@)",model.productName];
    
    _titleLabel.text = [NSString stringWithFormat:@"【积分】%@",model.name];
    _contentLabel.text = [NSString stringWithFormat:@"∙ 仅限购买%@\n∙ 具体操作可在优惠券页面查看",model.productName];
}
-(void)setIsType:(BOOL)isType{
    if (isType) {
        [_image setImage:[UIImage imageNamed:@"youhuiquan1"]];
    }else{
        [_image setImage:[UIImage imageNamed:@"youhuiquan2"]];
    }
}
-(void)initializeViews {
    _image = [[UIImageView alloc]init];
    [self.contentView addSubview:_image];
    
    _title=[[UILabel alloc]init];
    [_image addSubview:_title];
    
    _info=[[UILabel alloc]init];
    _info.font = [UIFont systemFontOfSize:Font_Size(33)];
    _info.textColor=[UIColor colorWithHexString:@"#feffe8"];
    [_image addSubview:_info];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
}
-(void)addConstraints {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(Width_Pt(36));
        make.width.mas_equalTo(Width_Pt(410));
        make.height.mas_equalTo(Height_Pt(215));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_image.mas_centerY).offset(-Height_Pt(10));
        make.centerX.equalTo(_image);
    }];
    
    [_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(25));
        make.centerX.equalTo(_image);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(80));
        make.left.equalTo(_image.mas_right).with.offset(Width_Pt(40));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(40));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(60));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(80));
    }];
}

@end
