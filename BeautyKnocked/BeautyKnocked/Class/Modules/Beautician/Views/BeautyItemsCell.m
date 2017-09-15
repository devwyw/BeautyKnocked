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

@property (nonatomic, strong) UILabel *vipLabel;

@property (nonatomic, strong) UILabel *purchaseLabel;

@property (nonatomic, strong) UIImageView *reserveBtn;

@end

@implementation BeautyItemsCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createInterface];
        [self makeConstraints];
    }
    return self;
}
-(void)createInterface {
    _itemImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemImgView];
    
    _itemNameLabel = [[UILabel alloc] init];
    _itemNameLabel.font = [UIFont systemFontOfSize:Font_Size(47.5)];
    [self.contentView addSubview:_itemNameLabel];
    
    _vipLabel = [[UILabel alloc] init];
    _vipLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_vipLabel];
    
    _purchaseLabel = [[UILabel alloc] init];
    _purchaseLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_purchaseLabel];
    
    _reserveBtn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixuanzhong_03"] highlightedImage:[UIImage imageNamed:@"xuanzhong_03"]];
    [self.contentView addSubview:_reserveBtn];
}
-(void)setModel:(ItemClassModel *)model{
    [Master GetWebImage:_itemImgView withUrl:model.imagePath];
    _itemNameLabel.text = model.name;
    NSString *price = [NSString stringWithFormat:@"VIP: ¥%@ ¥%@",model.vipPrice,model.price];
    _vipLabel.attributedText = [price setRedPrice:[NSString stringWithFormat:@"¥%@",model.vipPrice] linePrice:[NSString stringWithFormat:@"¥%@",model.price]];
    _purchaseLabel.text = [NSString stringWithFormat:@"%@人购买",model.buySecond];
    _reserveBtn.highlighted=model.isSelect;
}
-(void)makeConstraints {
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).with.offset(Height_Pt(20));
        make.size.mas_equalTo(CGSizeMake(Height_Pt(282), Height_Pt(282)));
    }];
    
    [_itemNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(50));
        make.left.equalTo(_itemImgView.mas_right).with.offset(Height_Pt(36));
        make.height.mas_equalTo(Height_Pt(54));
    }];
    
    [_vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(50));
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
