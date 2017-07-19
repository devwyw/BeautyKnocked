//
//  CouponDescriptionCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponDescriptionCell.h"

@interface CouponDescriptionCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descrLabel;

@end

@implementation CouponDescriptionCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(52)];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    _descrLabel.textColor = [UIColor lightGrayColor];
    _descrLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_descrLabel];
    
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(35));
        make.top.equalTo(self.contentView).with.offset(Height_Pt(45));
        make.height.mas_equalTo(Height_Pt(52));
    }];
    
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(50));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(60));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(45));
    }];
}

-(void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
-(void)setDescrText:(NSString *)descrText {
    _descrLabel.text = descrText;
}
-(void)setAttributedText:(NSAttributedString *)attributedText {
    _descrLabel.attributedText = attributedText;
}



@end
