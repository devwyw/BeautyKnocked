//
//  TitleCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@interface TitleCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation TitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [self.contentView addSubview:_titleLabel];
    
    _titleLabel.text = @"兑换商品";
}
-(void)addConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(35));
        make.centerY.equalTo(self.contentView);
    }];
}

@end
