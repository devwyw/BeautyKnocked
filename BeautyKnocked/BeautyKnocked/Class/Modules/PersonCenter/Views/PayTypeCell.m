//
//  PayTypeCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayTypeCell.h"

@interface PayTypeCell ()
@property (nonatomic,strong) UIImageView * selectImage;
@property (nonatomic,strong) UIImageView * payImage;
@property (nonatomic,strong) UILabel * payType;
@property (nonatomic,strong) UILabel * node;
@end

@implementation PayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setIsNode:(BOOL)isNode{
    if (isNode) {
        _payType.textColor=[UIColor lightGrayColor];
        _node.hidden=NO;
    }else{
        _payType.textColor=[UIColor blackColor];
        _node.hidden=YES;
    }
}
-(void)setIsSelected:(BOOL)isSelected{
    _selectImage.highlighted=isSelected;
}
-(void)setModel:(NSDictionary *)model{
    _payImage.image=[UIImage imageNamed:model[@"image"]];
    _payType.text=model[@"name"];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _selectImage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan"] highlightedImage:[UIImage imageNamed:@"gouxuan"]];
    self.accessoryView =_selectImage;
    [self.accessoryView setFrame:CGRectMake(0, 0, Width_Pt(60), Height_Pt(60))];
    
    _payImage=[[UIImageView alloc]init];
    [_payImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:_payImage];
    
    _payType=[[UILabel alloc]init];
    _payType.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_payType];
    
    _node=[[UILabel alloc]init];
    _node.text=@"(*本次交易不支持)";
    _node.textColor=[UIColor lightGrayColor];
    _node.font=[UIFont systemFontOfSize:Font_Size(40)];
    _node.hidden=YES;
    [self.contentView addSubview:_node];
}
-(void)addConstraints {
    [_payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(20));
        make.left.equalTo(self.contentView).offset(Width_Pt(50));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(120), Height_Pt(120)));
    }];
    [_payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payImage);
        make.left.equalTo(_payImage.mas_right).offset(Width_Pt(65));
    }];
    [_node mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payType);
        make.left.equalTo(_payType.mas_right).offset(Width_Pt(20));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
