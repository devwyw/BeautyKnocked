//
//  AddressEditView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddressEditView.h"

@interface AddressEditView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) UIView * line;

@end

@implementation AddressEditView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:_line];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [self addSubview:_nameLabel];
    [self addSubview:_textField];
}
-(void)addConstraints {
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.offset(0.5);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(50));
        make.centerY.equalTo(self);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(298));
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(50));
    }];
}
-(void)setTitle:(NSString *)title {
    _nameLabel.text = title;
}
-(void)setFather:(id)father{
    [_textField setDelegate:father];
}
-(void)setContent:(NSString *)content {
    _textField.text = content;
}
-(void)setPlaceholder:(NSString *)placeholder {
    _textField.placeholder = placeholder;
}
-(NSString *)content{
    return _textField.text;
}
-(UITextField *)textField{
    return _textField;
}

@end
