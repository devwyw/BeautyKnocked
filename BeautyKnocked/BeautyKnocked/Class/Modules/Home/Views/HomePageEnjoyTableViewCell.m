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
@property (nonatomic,strong) UIView * whiteview;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *monthSaleLabel;
@end

@implementation HomePageEnjoyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setModel:(ItemClassModel *)model{
    [Master GetWebImage:_imgView withUrl:model.imagePath];
    _titleLabel.text = model.name;
    NSString *price = [NSString stringWithFormat:@"VIP: ¥%@ ¥%@",model.vipPrice,model.price];
    _priceLabel.attributedText = [price setRedPrice:[NSString stringWithFormat:@"¥%@",model.vipPrice] linePrice:[NSString stringWithFormat:@"¥%@",model.price]];
    _monthSaleLabel.text = [NSString stringWithFormat:@"月售%@单",model.buySecond];
}
-(void)setupInterface {
    _whiteview=[[UIView alloc]init];
    _whiteview.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_whiteview];
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"mote_03"]];
    [_whiteview addSubview:_imgView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(55)];
    [_whiteview addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    [_whiteview addSubview:_priceLabel];
    
    _monthSaleLabel = [[UILabel alloc] init];
    _monthSaleLabel.font = [UIFont systemFontOfSize:Font_Size(32)];
    [_whiteview addSubview:_monthSaleLabel];
}

-(void)setupConstraints {
    [_whiteview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteview).with.offset(Height_Pt(35));
        make.left.equalTo(_whiteview).with.offset(Width_Pt(82));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(250), Height_Pt(250)));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteview).with.offset(Height_Pt(42));
        make.left.equalTo(_priceLabel);
        make.height.mas_equalTo(Height_Pt(55));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(100));
        make.centerX.equalTo(_whiteview);
        make.height.mas_equalTo(Height_Pt(32));
    }];

    [_monthSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).with.offset(Height_Pt(32));
        make.left.equalTo(_priceLabel);
        make.height.mas_equalTo(Height_Pt(32));
    }];
}


@end
