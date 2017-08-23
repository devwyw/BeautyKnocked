//
//  ConfirmOrderAddressCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderAddressCell.h"
#import "AddressModel.h"

@interface ConfirmOrderAddressCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telNumberLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel * title;
@end

@implementation ConfirmOrderAddressCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setIsNull:(BOOL)isNull{
    if (isNull) {
        _title.hidden=!isNull;
    }
}
-(void)setModel:(AddressModel *)model{
    _title.hidden=YES;
    _nameLabel.text = [NSString stringWithFormat:@"顾客姓名: %@",model.name];
    _telNumberLabel.text = model.phone;
    _addressLabel.text = [NSString stringWithFormat:@"服务地址: %@",model.address];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"dizhi"]];
    
    UIFont *font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = font;
    
    _telNumberLabel = [[UILabel alloc] init];
    _telNumberLabel.font = font;
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = font;
    _addressLabel.numberOfLines = 0;
    
    _title = [[UILabel alloc] init];
    _title.font = font;
    _title.text=@"请选择您的服务地址";
    _title.hidden=YES;
    
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_telNumberLabel];
    [self.contentView addSubview:_addressLabel];
}
-(void)addConstraints {
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(50));
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(60), Height_Pt(70)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(50));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(50));
        make.height.mas_equalTo(42);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(25));
        make.right.equalTo(self.contentView).with.offset( -  8);
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(50));
    }];
    
    [_telNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.right.equalTo(self.contentView).with.offset( - 8);
    }];
}

@end
