//
//  ServiceContentCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ServiceContentCollectionViewCell.h"

@interface ServiceContentCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *serialNumberLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ServiceContentCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _imgView = [[UIImageView alloc] init];
    
    _serialNumberLabel = [[UILabel alloc] init];
    _serialNumberLabel.font = [UIFont systemFontOfSize:Font_Size(30)];
    _serialNumberLabel.textColor =  [UIColor whiteColor];
    _serialNumberLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _serialNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];

    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLabel];
    [_imgView addSubview:_serialNumberLabel];
}
-(void)addConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(Height_Pt(256));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_imgView.mas_bottom).with.offset(Height_Pt(28));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(28));
    }];
    
    [_serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(_imgView);
        make.width.mas_equalTo(Width_Pt(64));
        make.height.mas_equalTo(Height_Pt(64));
    }];
}
-(void)setModel:(ImageModel *)model{
    _titleLabel.text=model.name;
    [Master GetWebImage:_imgView withUrl:model.imagePath];
}
-(void)setSerialNumber:(NSInteger)serialNumber {
    _serialNumberLabel.text = [NSString stringWithFormat:@"%ld",serialNumber];
}
@end
