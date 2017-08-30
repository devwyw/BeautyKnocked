//
//  ServiceCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ServiceCell.h"


@interface ServiceCell ()
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * message;
@end

@implementation ServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setImageName:(NSString *)imageName{
    _image.image=[UIImage imageNamed:imageName];
}
-(void)setTitleText:(NSString *)titleText{
    _title.text=titleText;
}
-(void)setMessageText:(NSString *)messageText{
    _message.text=messageText;
}
-(void)initializeViews {
    _image=[[UIImageView alloc]init];
    [_image setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:_image];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_title];
    
    _message=[[UILabel alloc]init];
    _message.font=[UIFont systemFontOfSize:Font_Size(35)];
    _message.textColor=[UIColor darkGrayColor];
    _message.numberOfLines=0;
    [self.contentView addSubview:_message];
}
-(void)addConstraints {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Width_Pt(60));
        make.centerY.equalTo(self.contentView);
        make.size.sizeOffset(CGSizeMake(Width_Pt(70), Height_Pt(70)));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(35));
        make.left.equalTo(_image.mas_right).offset(Width_Pt(60));
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(_title);
        make.right.equalTo(self.contentView).offset(-Width_Pt(60));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(40));
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
