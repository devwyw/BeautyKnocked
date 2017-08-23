//
//  CommonAddressCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CommonAddressCell.h"
#import "AddressModel.h"

@interface CommonAddressCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *updateBtn;

@end

@implementation CommonAddressCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(AddressModel *)model{
    if ([model.isDefault integerValue]==1) {
        NSString *defaultSign = @"[默认]";
        NSString *newAddress=[NSString stringWithFormat:@"%@%@",defaultSign,model.address];
        NSRange defaultRange = [newAddress rangeOfString:defaultSign];
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:newAddress];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:ThemeColor range:defaultRange];
        _addressLabel.attributedText = attributeStr;
    }else{
        _addressLabel.text=model.address;
    }
    _nameLabel.text = model.name;
    _telLabel.text = model.phone;
}
-(RACSignal *)addressEditSignal{
    return [_updateBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal *)addressDeleteSignal {
    return [_deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

-(void)initializeViews {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.textColor=[UIColor darkGrayColor];
    _addressLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _addressLabel.numberOfLines = 0;
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    
    _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_updateBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_telLabel];
    [self.contentView addSubview:_addressLabel];
    
    [self.contentView addSubview:_deleteBtn];
    [self.contentView addSubview:_updateBtn];
}

-(void)addConstraints {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(55));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(48));
        make.height.mas_equalTo(Height_Pt(52));
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).with.offset(8);
        make.height.equalTo(_nameLabel.mas_height);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(20));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(200));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(35));
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(35));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(50));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(66), Height_Pt(60)));
    }];
    
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_deleteBtn);
        make.bottom.equalTo(self.contentView).with.offset( - Width_Pt(35));
        make.size.equalTo(_deleteBtn);
    }];
}

@end
