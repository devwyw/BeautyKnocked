//
//  MLDateCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MLDateCollectionViewCell.h"

@interface MLDateCollectionViewCell ()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MLDateCollectionViewCell


-(void)setDateNumber:(NSString *)dateNumber {
    _numberLabel.text = dateNumber;
}
-(void)setContent:(NSString *)content {
    _contentLabel.text = content;
}

-(void)setNumberColor:(UIColor *)numberColor {
    _numberLabel.textColor = numberColor;
}
-(void)setContentColor:(UIColor *)contentColor {
    _contentLabel.textColor = contentColor;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    
//    // selected
//    UIView *selectedView = [[UIView alloc] init];
//    selectedView.backgroundColor = ThemeColor;
//    self.selectedBackgroundView = selectedView;
    
    
    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:_contentLabel];
    
}
-(void)addConstraints {
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.equalTo(_contentLabel);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numberLabel.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.bottom.and.left.and.right.equalTo(self.contentView);
    }];
}



@end
