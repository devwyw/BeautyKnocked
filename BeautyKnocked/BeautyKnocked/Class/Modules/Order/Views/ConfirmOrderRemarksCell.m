//
//  ConfirmOrderRemarksCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderRemarksCell.h"
#import <IQTextView.h>

@interface ConfirmOrderRemarksCell ()

@property (nonatomic, strong) UILabel *remarksLabel;
@property (nonatomic, strong) IQTextView *inputTextView;

@end

@implementation ConfirmOrderRemarksCell


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
-(void)setText:(NSString *)text{
    _inputTextView.text=text;
}
-(void)initializeViews {
    _remarksLabel = [[UILabel alloc] init];
    _remarksLabel.text = @"备注:";
    _remarksLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _inputTextView = [[IQTextView alloc] init];
    _inputTextView.placeholder = @"(选填)描述您对本次交易的说明";
    Weakify(self);
    [[_inputTextView rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        [Wself.subText sendNext:x];
    }];
    _inputTextView.font = _remarksLabel.font;
    
    [self.contentView addSubview:_remarksLabel];
    [self.contentView  addSubview:_inputTextView];
}
-(void)addConstraints {
    [_remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
        make.top.equalTo(self.contentView).with.offset(12);
        make.width.mas_equalTo(40);
    }];
    
    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.left.equalTo(_remarksLabel.mas_right).with.offset(8);
        make.right.equalTo(self.contentView).with.offset( - 8);
        make.bottom.equalTo(self.contentView).with.offset( -12);
        make.height.mas_equalTo(80);
    }];
}

@end
