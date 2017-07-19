//
//  BeautyItemsCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeautyItemsCell.h"
#import "NSString+Attribute.h"

@interface BeautyItemsCell ()

@property (nonatomic, strong) UIImageView *itemImgView;

@property (nonatomic, strong) UILabel *itemNameLabel;

@property (nonatomic, strong) UILabel *briefingLabel;

@property (nonatomic, strong) UILabel *vipLabel;

/**
 purchase count people
 */
@property (nonatomic, strong) UILabel *purchaseLabel;

@property (nonatomic, strong) UIButton *reserveBtn;

@end

@implementation BeautyItemsCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createInterface];
        [self makeConstraints];
    }
    return self;
}

-(void)createInterface {
    
    _itemImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemImgView];
    
    _itemNameLabel = [[UILabel alloc] init];
    _itemNameLabel.font = [UIFont systemFontOfSize:Font_Size(54)];
    [self.contentView addSubview:_itemNameLabel];
    
    _briefingLabel = [[UILabel alloc] init];
    _briefingLabel.textColor = [UIColor lightGrayColor];
    _briefingLabel.font = [UIFont systemFontOfSize:Font_Size(46)];
    [self.contentView addSubview:_briefingLabel];
    
    _vipLabel = [[UILabel alloc] init];
    _vipLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    [self.contentView addSubview:_vipLabel];
    
    _purchaseLabel = [[UILabel alloc] init];
    _purchaseLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_purchaseLabel];
    
    _reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reserveBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong_03"] forState:UIControlStateNormal];
    [_reserveBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong_03"] forState:UIControlStateSelected];
    [self.contentView addSubview:_reserveBtn];
    
    // event
    [[_reserveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable reserveBtn) {
        reserveBtn.selected = !reserveBtn.selected;
    }];

    
    [_itemImgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    _itemNameLabel.text = @"水美人";
    _briefingLabel.text = @"芳香开背 深层清洁";
    NSString *price = @"VIP: ¥88 ¥148";
    _vipLabel.attributedText = [price setRedPrice:@"¥88" linePrice:@"¥148"];
    
    _purchaseLabel.text = @"22人购买";
    
}

-(void)makeConstraints {
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).with.offset(Height_Pt(20));
        make.size.mas_equalTo(CGSizeMake(Height_Pt(282), Height_Pt(282)));
    }];
    
    [_itemNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(60));
        make.left.equalTo(_itemImgView.mas_right).with.offset(Height_Pt(36));
        make.height.mas_equalTo(Height_Pt(54));
    }];
    
    [_briefingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_itemNameLabel.mas_bottom).with.offset(Height_Pt(27));
        make.left.equalTo(_itemNameLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(48));
    }];
    
    [_vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_briefingLabel.mas_bottom).with.offset(Height_Pt(27));
        make.left.equalTo(_itemNameLabel.mas_left);
        make.height.mas_equalTo(Height_Pt(36));
    }];
    
    [_purchaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_vipLabel);
        make.left.equalTo(_vipLabel.mas_right).with.offset(Width_Pt(60));
        make.height.equalTo(_vipLabel.mas_height);
    }];
    
    [_reserveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(Width_Pt(120));
    }];
}

@end
