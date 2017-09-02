//
//  RechargeItemCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/9/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeItemCell.h"

@interface RechargeItemCell ()
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UILabel * num;
@property (nonatomic,strong) UIImageView * image;
@end

@implementation RechargeItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setMyViews];
        [self setMyFrames];
    }
    return self;
}
-(void)setModel:(RechargeItemInfoModel *)model{
    _name.text=model.name;
    _num.text=[NSString stringWithFormat:@"x%@",model.num];
    _image.highlighted=model.isSelected;
}
-(void)setMyViews{
    _image= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan2"] highlightedImage:[UIImage imageNamed:@"gouxuanh"]];
    self.accessoryView =_image;
    
    _name=[[UILabel alloc]init];
    _name.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_name];
    
    _num=[[UILabel alloc]init];
    _num.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_num];
}
-(void)setMyFrames{
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(20));
        make.left.equalTo(self.contentView).offset(Width_Pt(60));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
    }];
    
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
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
