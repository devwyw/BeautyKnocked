//
//  ConfirmOrderItemCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderItemCell.h"

@interface ConfirmOrderItemCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *serviceLenghtLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ConfirmOrderItemCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setItemImage:(UIImage *)itemImage {
    [_imgView setImage:itemImage];
}
-(void)setItemName:(NSString *)itemName {
    _titleLabel.text = itemName;
}
-(void)setServiceLength:(NSString *)serviceLength {
    _serviceLenghtLabel.text = serviceLength;
}
-(void)setPrice:(NSAttributedString *)price {
    _priceLabel.attributedText = price;
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
    
    _imgView = [[UIImageView alloc] init];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:Font_Size(40)];
    
    _serviceLenghtLabel = [[UILabel alloc] init];
    _serviceLenghtLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_serviceLenghtLabel];
    [self.contentView addSubview:_priceLabel];
    
}
-(void)addConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(8);
        make.left.equalTo(self.contentView).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(240), Height_Pt(240)));
        make.bottom.equalTo(self.contentView).with.offset( - 8);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(8);
        make.top.equalTo(_imgView.mas_top).with.offset(8);
    }];
    
    [_serviceLenghtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).with.offset( - 15);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(- 8);
    }];

}

@end
