//
//  MenuItemCollectionCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MenuItemCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MenuItemCollectionCell ()

@property (nonatomic, strong) UIImageView *menuItemImgView;

@property (nonatomic, strong) UILabel *menuItemLabel;

@end

@implementation MenuItemCollectionCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
        [self configureConstraints];
    }
    return self;
}

-(void)createInterface {
    _menuItemLabel = [[UILabel alloc] init];
    _menuItemLabel.text = @"项目名称";
    [self.contentView addSubview:_menuItemLabel];
    
    _menuItemImgView = [[UIImageView alloc] init];
    _menuItemImgView.image = [UIImage imageNamed:@"touxiang_03"];
    [self.contentView addSubview:_menuItemImgView];
}

-(void)configureConstraints {
    [_menuItemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(_topDistance);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(_imgeViewSize);
    }];
    
    [_menuItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_menuItemImgView.mas_bottom).with.offset(_middleDistance);
        make.bottom.equalTo(self.contentView).with.offset( - _bottomDistance);
        make.centerX.equalTo(self.contentView);
    }];
}

-(void)layoutSubviews {
    [_menuItemImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(_topDistance);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(_imgeViewSize);
    }];
    
    [_menuItemLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_menuItemImgView.mas_bottom).with.offset(_middleDistance);
        make.bottom.equalTo(self.contentView).with.offset( - _bottomDistance);
        make.centerX.equalTo(self.contentView);
    }];
    [super layoutSubviews];
}


-(void)setTitleColor:(UIColor *)titleColor {
    _menuItemLabel.textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont {
    _menuItemLabel.font = titleFont;
}

-(void)setImageUrl:(NSString *)imageUrl {
    [_menuItemImgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

-(void)setImageName:(NSString *)imageName {
    [_menuItemImgView setImage:[UIImage imageNamed:imageName]];
}

-(void)setMenuItemName:(NSString *)menuItemName {
    _menuItemLabel.text = [NSString stringWithFormat:@"%@",menuItemName];
}

@end
