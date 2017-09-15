//
//  HomePageItemCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageItemCollectionViewCell.h"
#import "NSString+Attribute.h"

@interface HomePageItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation HomePageItemCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setupInterface {
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    [self.contentView addSubview:_priceLabel];
}
-(void)setModel:(ItemClassModel *)model{
    _titleLabel.text = model.name;
    [Master GetWebImage:_imgView withUrl:model.imagePath];
    NSString *text = [NSString stringWithFormat:@"VIP: ¥%@ ¥%@",model.vipPrice,model.price];
    _priceLabel.attributedText = [text setRedPrice:[NSString stringWithFormat:@"¥%@",model.vipPrice] linePrice:[NSString stringWithFormat:@"¥%@",model.price]];
}
-(void)setupConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(Height_Pt(300));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView);
        make.top.equalTo(_imgView.mas_bottom).with.offset(Height_Pt(20));
        make.right.equalTo(self.contentView);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(15));
    }];
}

@end
