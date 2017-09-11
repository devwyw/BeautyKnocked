//
//  IntegraHeaderCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegraHeaderCell.h"

@interface IntegraHeaderCell ()
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * info;
@end

@implementation IntegraHeaderCell

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
    NSString *text=[NSString stringWithFormat:@"¥%@",[model.name stringByReplacingOccurrencesOfString:@"元" withString:@" "]];
    NSString *name=[model.name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@元",model.price] withString:@""];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange minRange = [text rangeOfString:name];
    NSRange maxRange = [text rangeOfString:model.price];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, 1)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(48.5)] range:minRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:Font_Size(70)] range:maxRange];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#feffe8"] range:NSMakeRange(0, text.length)];
    
    _title.attributedText = attributeStr;
    _info.text = [NSString stringWithFormat:@"(限购%@)",model.productName];
}
-(void)setIsType:(BOOL)isType{
    if (isType) {
        [_image setImage:[UIImage imageNamed:@"youhuiquan1"]];
    }else{
        [_image setImage:[UIImage imageNamed:@"youhuiquan2"]];
    }
}
-(void)initializeViews {
    _image=[[UIImageView alloc]init];
    [self.contentView addSubview:_image];
    
    _title=[[UILabel alloc]init];
    [_image addSubview:_title];
    
    _info=[[UILabel alloc]init];
    _info.font = [UIFont systemFontOfSize:Font_Size(35)];
    _info.textColor=[UIColor colorWithHexString:@"#feffe8"];
    [_image addSubview:_info];
}
-(void)addConstraints {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(51));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(52));
        make.size.sizeOffset(CGSizeMake(Width_Pt(574), Height_Pt(301)));
        make.centerX.equalTo(self.contentView);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_image.mas_centerY).offset(-Height_Pt(12));
        make.centerX.equalTo(_image);
    }];
    
    [_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(40));
        make.centerX.equalTo(_image);
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
