//
//  HomePageEnjoyTableViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageEnjoyTableViewCell.h"
#import "NSString+Attribute.h"

@interface HomePageEnjoyTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *categoryLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descrLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *monthSaleLabel;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation HomePageEnjoyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"mote_03"]];
    [self.contentView addSubview:_imgView];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    _categoryLabel.textAlignment = NSTextAlignmentCenter;
    _categoryLabel.textColor = [UIColor whiteColor];
    UIImage *backImage = [UIImage imageNamed:@"xiangmubj_03"];
    _categoryLabel.text = @"面部";
    [_categoryLabel setBackgroundColor:[UIColor colorWithPatternImage:backImage]];
    [self.contentView addSubview:_categoryLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(55)];
    _titleLabel.text = @"驻养焕颜课程";
    [self.contentView addSubview:_titleLabel];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _descrLabel.text = @"提升紧致  深层补水";
    [self.contentView addSubview:_descrLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    NSString *price = @"VIP: ¥980 ¥1980";
    _priceLabel.attributedText = [price setRedPrice:@"¥980" linePrice:@"¥1980"];
    [self.contentView addSubview:_priceLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    _timeLabel.text = @"90分钟";
    [self.contentView addSubview:_timeLabel];
    
    _monthSaleLabel = [[UILabel alloc] init];
    _monthSaleLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    _monthSaleLabel.text = @"月售32单";
    [self.contentView addSubview:_monthSaleLabel];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong_03"] forState:UIControlStateNormal];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong_03"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectBtn];
    
    [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable selectBtn) {
        selectBtn.selected = !selectBtn.selected;
    }];
    
}

-(void)setupConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(22));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(82));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(250), Height_Pt(280)));
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(-Width_Pt(40));
        make.bottom.equalTo(self.contentView).with.offset(-Height_Pt(34));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(95), Height_Pt(42)));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(42));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(158));
        make.height.mas_equalTo(Height_Pt(55));
    }];
    
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_titleLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descrLabel.mas_bottom).with.offset(Height_Pt(32));
        make.left.equalTo(_titleLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(32));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).with.offset(Height_Pt(32));
        make.left.equalTo(_titleLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(32));
    }];
    
    [_monthSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLabel);
        make.left.equalTo(_timeLabel.mas_right).with.offset(Width_Pt(80));
        make.height.equalTo(_timeLabel);
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Pt(120));
    }];
    
}


@end
