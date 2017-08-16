//
//  PayTypeCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayTypeCell.h"

@interface PayTypeCell ()
@property (nonatomic,strong) UIImageView * payImage;
@property (nonatomic,strong) UILabel * payType;
@end

@implementation PayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan"] highlightedImage:[UIImage imageNamed:@"gouxuan"]];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _payImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhifubao"]];
    [self.contentView addSubview:_payImage];
    
    _payType=[[UILabel alloc]init];
    _payType.font=[UIFont systemFontOfSize:Font_Size(40)];
    _payType.text=@"支付宝支付";
    [self.contentView addSubview:_payType];
}
-(void)addConstraints {
    [_payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(20));
        make.left.equalTo(self.contentView).offset(Width_Pt(50));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(121), Height_Pt(121)));
    }];
    [_payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payImage);
        make.left.equalTo(_payImage.mas_right).offset(Width_Pt(65));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
