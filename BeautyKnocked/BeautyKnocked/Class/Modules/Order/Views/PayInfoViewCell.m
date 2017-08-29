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
