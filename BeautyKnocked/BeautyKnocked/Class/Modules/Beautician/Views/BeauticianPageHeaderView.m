//
//  BeauticianPageHeaderView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianPageHeaderView.h"
#import "StarView.h"

@interface BeauticianPageHeaderView ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) StarView *starView;

@property (nonatomic, strong) UIView *line;

@end

@implementation BeauticianPageHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupControls];
        [self setupConstraints];
    }
    return self;
}
-(void)setModel:(BeauticianModel *)model{
    [Master GetWebImage:_imgView withUrl:model.headPath];
    _nameLabel.text = model.name;
    _starView.starCount=[model.score integerValue];
}
-(void)setupControls {
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(42)];
    [self addSubview:_nameLabel];
    
    _starView = [StarView evaluationViewWithChooseStarBlock:nil];
    _starView.spacing = 0.1;
    _starView.tapEnabled = NO;
    [self addSubview:_starView];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
}

-(void)setupConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(30));
        make.left.equalTo(self).with.offset(Width_Pt(40));
        make.width.mas_equalTo(Width_Pt(162));
        make.height.mas_equalTo(Height_Pt(162));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(60));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(40));
        make.height.mas_equalTo(Height_Pt(43));
    }];
    
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(30));
        make.width.mas_equalTo(Width_Pt(254));
        make.height.mas_equalTo(Height_Pt(55));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
}

@end
