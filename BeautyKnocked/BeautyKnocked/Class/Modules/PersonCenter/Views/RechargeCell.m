//
//  RechargeCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeCell.h"
#import "UIImageView+Category.h"

@interface RechargeCell ()
@property (nonatomic,strong) UIImageView * backimage;
@property (nonatomic,strong) UIImageView * vipimage;
@property (nonatomic,strong) UIImageView * lineimage;
@property (nonatomic,strong) UILabel * recharge;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * message;
@end

@implementation RechargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setMyViews];
        [self setMyFrames];
    }
    return self;
}
-(void)setMyViews{
    _backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chongzhikabj"]];
    [self.contentView addSubview:_backimage];
    
    _lineimage=[[UIImageView alloc]init];
    [_backimage addSubview:_lineimage];
}
-(void)setMyFrames{
    [_backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(40));
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(Width_Pt(25));
        make.right.equalTo(self.contentView).offset(-Width_Pt(25));
    }];
    [_lineimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backimage).offset(Width_Pt(85));
        make.right.equalTo(_backimage).offset(-Width_Pt(340));
        make.bottom.equalTo(_backimage).offset(-Height_Pt(85));
        make.height.mas_equalTo(Height_Pt(5));
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)layoutSubviews{
    _lineimage.image=[_lineimage drawLineImage:2 withLineHeight:Height_Pt(5) withColor:[UIColor blackColor]];
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
