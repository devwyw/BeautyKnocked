//
//  ConfirmOrderFillCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderFillCell.h"

@interface ConfirmOrderFillCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ConfirmOrderFillCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
-(void)setContent:(NSString *)content {
    _contentLabel.text = content;
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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = _titleLabel.font;
    _contentLabel.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_contentLabel];
}
-(void)addConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset( - 8);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
