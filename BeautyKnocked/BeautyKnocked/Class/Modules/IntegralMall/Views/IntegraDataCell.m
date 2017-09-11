//
//  IntegraDataCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegraDataCell.h"
#import "NSString+Attribute.h"

@interface IntegraDataCell ()
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * score;
@property (nonatomic,strong) UILabel * price;
@end

@implementation IntegraDataCell

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
    _title.text=model.name;
    
    NSString *text=[NSString stringWithFormat:@"%@ 积分",model.integral];
    NSMutableAttributedString *attScore=[text setMinString:@"积分" withMinFont:Font_Size(40) andMaxString:model.integral withMaxFont:Font_Size(56)];
    [attScore addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5000"] range:NSMakeRange(0, text.length)];
    _score.attributedText=attScore;
    
    NSString *texts=[NSString stringWithFormat:@"¥%@.0",model.price];
    NSMutableAttributedString *attPrice = [[NSMutableAttributedString alloc] initWithString:texts];
    [attPrice addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0),NSStrikethroughColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, texts.length)];
    _price.attributedText=attPrice;
}
-(void)initializeViews {
    _title=[[UILabel alloc]init];
    _title.font = [UIFont systemFontOfSize:Font_Size(50)];
    [self.contentView addSubview:_title];
    
    _score=[[UILabel alloc]init];
    [self.contentView addSubview:_score];
    
    _price=[[UILabel alloc]init];
    [self.contentView addSubview:_price];
}
-(void)addConstraints {
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Pt(40));
        make.top.equalTo(self.contentView).offset(Height_Pt(50));
    }];
    
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(40));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(50));
        make.left.equalTo(_title);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_score.mas_right).offset(Width_Pt(55));
        make.centerY.equalTo(_score);
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
