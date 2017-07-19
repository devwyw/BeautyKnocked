//
//  BeauticianRegisterInputCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianRegisterInputCell.h"

@interface BeauticianRegisterInputCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation BeauticianRegisterInputCell

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
    _titleLabel.font =[UIFont systemFontOfSize:Font_Size(45)];
    [self.contentView addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.font =[UIFont systemFontOfSize:Font_Size(45)];
    [self.contentView addSubview:_textField];
}

-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(45));
        make.centerY.equalTo(self.contentView);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(335));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset( - 8);
    }];
    
}

-(void)setPlaceholder:(NSString *)placeholder {
    _textField.placeholder = placeholder;
}

-(void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

-(NSString *)textFieldContent {
    return _textField.text;
}

@end
