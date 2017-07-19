//
//  ConfirmOrderAddressCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderAddressCell.h"

@interface ConfirmOrderAddressCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telNumberLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation ConfirmOrderAddressCell

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
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_telNumberLabel];
    [self.contentView addSubview:_addressLabel];
    
    _nameLabel.text = @"顾客姓名: 刘亦菲";
    _telNumberLabel.text = @"15074568566";
    _addressLabel.text = @"服务地址: 喜马拉雅山脚下白雪广场边缘100号洞天桃源小世界王府1050房";
    
}
-(void)addConstraints {
    
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
