//
//  OrderItemTableViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderItemTableViewCell.h"

@interface OrderItemTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *orderNameLabel;
@property (nonatomic, strong) UILabel *serviceTimeLabel;
@property (nonatomic, strong) UILabel *serviceAddressLabel;

@property (nonatomic, strong) UILabel *unitPriceLabel;
@property (nonatomic, strong) UILabel *serviceTimesLabel;

@property (nonatomic, strong) UILabel *amountPriceLabel;

@end

@implementation OrderItemTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =[UIColor colorWithHexString:@"#F7F7F7"];
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setupInterface {
    UIFont *font = [UIFont systemFontOfSize:Font_Size(35)];
    
    UIView *topline=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    [topline setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:topline];
    
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    
    _orderNameLabel = [[UILabel alloc] init];
    _orderNameLabel.font = font;
    [self.contentView addSubview:_orderNameLabel];
    
    _serviceTimeLabel = [[UILabel alloc] init];
    _serviceTimeLabel.font = font;
    [self.contentView addSubview:_serviceTimeLabel];
    
    _serviceAddressLabel = [[UILabel alloc] init];
    _serviceAddressLabel.font = font;
    [self.contentView addSubview:_serviceAddressLabel];
    
    _unitPriceLabel = [[UILabel alloc] init];
    _unitPriceLabel.font = font;
    [self.contentView addSubview:_unitPriceLabel];
    
    _serviceTimesLabel = [[UILabel alloc] init];
    _serviceTimesLabel.font = font;
    [self.contentView addSubview:_serviceTimesLabel];
    
    _amountPriceLabel = [[UILabel alloc] init];
    _amountPriceLabel.font = font;
    _amountPriceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_amountPriceLabel];
}
-(void)setModel:(OrderInfoListModel *)model{
    [Master GetWebImage:_imgView withUrl:model.imagePath];
    _orderNameLabel.text = [NSString stringWithFormat:@"订单名称：%@",model.name];
    _serviceAddressLabel.text = [NSString stringWithFormat:@"服务地址：%@",_addRess];
    _unitPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    _serviceTimesLabel.text = [NSString stringWithFormat:@"x%@",model.num];
    _amountPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.money];
    if (_isProduct) {
        _serviceTimeLabel.text = nil;
    }else{
        NSTimeInterval interval=[[_time substringToIndex:10] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *timeString = [dateformatter stringFromDate:date];
        _serviceTimeLabel.text = [NSString stringWithFormat:@"服务时间：%@",timeString];
    }
}
-(void)setupConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(Width_Pt(40));
        make.width.mas_equalTo(Width_Pt(242));
        make.height.mas_equalTo(Height_Pt(240));
    }];
    
    [_orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(44));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(15));
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [_serviceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderNameLabel.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_orderNameLabel.mas_left);
        make.height.equalTo(_orderNameLabel.mas_height);
    }];
    
    [_serviceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNameLabel.mas_left);
        make.top.equalTo(_serviceTimeLabel.mas_bottom).with.offset(Height_Pt(30));
        make.right.equalTo(_unitPriceLabel.mas_right);
        make.height.equalTo(_orderNameLabel.mas_height);
    }];
    
    [_unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderNameLabel);
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(30));
        make.height.equalTo(_orderNameLabel.mas_height);
    }];
    
    [_serviceTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_serviceTimeLabel);
        make.right.equalTo(_unitPriceLabel.mas_right);
        make.height.equalTo(_orderNameLabel.mas_height);
    }];
    
    [_amountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceAddressLabel.mas_bottom).with.offset(Height_Pt(12));
        make.right.equalTo(_unitPriceLabel.mas_right);
        make.height.equalTo(_orderNameLabel.mas_height);
    }];
}

@end
