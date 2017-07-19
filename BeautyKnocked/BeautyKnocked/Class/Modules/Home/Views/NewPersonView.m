//
//  NewPersonView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NewPersonView.h"

@interface NewPersonView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation NewPersonView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createInterface];
        [self configureConstraints];
    }
    return self;
}

-(void)createInterface {
    
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] init];
    [self addSubview:_detailLabel];
    
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    
    _button =[[UIButton alloc]init];
    [self addSubview:_button];
    
}

-(void)configureConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(12));
        make.top.equalTo(self).with.offset(Height_Pt(36));
        make.height.mas_equalTo(Height_Pt(46));
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(12));
        make.height.mas_equalTo(Height_Pt(30));
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset( - Width_Pt(23));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(175), Height_Pt(117)));
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


-(void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

-(void)setDescr:(NSString *)descr {
    _detailLabel.text = descr;
}

-(void)setImage:(UIImage *)image {
    [_imgView setImage:image];
    
}

-(void)setImageSize:(CGSize)imageSize {
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imageSize);
    }];
}

-(void)setTitleFont:(UIFont *)titleFont {
    _titleLabel.font = titleFont;
}

-(void)setDescrFont:(UIFont *)descrFont {
    _detailLabel.font = descrFont;
}

@end
