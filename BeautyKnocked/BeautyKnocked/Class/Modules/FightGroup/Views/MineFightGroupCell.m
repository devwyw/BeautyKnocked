//
//  MineFightGroupCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineFightGroupCell.h"

@interface MineFightGroupCell ()

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UIImageView *hourglassImgView;
@property (nonatomic, strong) UILabel *hourglassLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) NSArray *buttonTitles;


@end
@implementation MineFightGroupCell

-(NSArray *)buttonTitles {
    if (!_buttonTitles) {
        _buttonTitles = @[@"邀请好友成团",@"查看拼团详情",@"领取拼团券",@"领取成功",@"查看退款状态"];
    }
    return _buttonTitles;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
// config data
-(void)setOrderNumber:(NSString *)orderNumber {
    _orderNumberLabel.text = orderNumber;
}
-(void)setDate:(NSString *)date {
    _dateLabel.text = date;
}
-(void)setStatus:(NSString *)status {
    _statusLabel.text = status;
}
-(void)setImageName:(NSString *)imageName {
    [_imgView setImage:[UIImage imageNamed:imageName]];
}
-(void)setItemName:(NSString *)itemName {
    _titlelabel.text = itemName;
}
-(void)setPeople:(NSString *)people {
    _peopleLabel.text = people;
}
-(void)setHourglass:(NSString *)hourglass {
    _hourglassLabel.text = hourglass;
}
-(void)setPrice:(NSAttributedString *)price {
    _priceLabel.attributedText = price;
}
-(void)setTitle0:(NSString *)title0 {
    [_leftBtn setTitle:title0 forState:UIControlStateNormal];
}
-(void)setTitle1:(NSString *)title1 {
    [_rightBtn setTitle:title1 forState:UIControlStateNormal];
    
    BOOL have = [title1 isEqualToString:@"查看拼团详情"] || [title1 isEqualToString:@"领取成功"];
    
    UIImage *backImage = have ? [UIImage imageNamed:@"huikuang"] : [UIImage imageNamed:@"huangkuang"];
    UIColor *titleColor = have ? [UIColor grayColor] : [UIColor whiteColor];

    [_rightBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [_rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _orderNumberLabel = [[UILabel alloc] init];
    _orderNumberLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    _orderNumberLabel.textColor = [UIColor lightGrayColor];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    _dateLabel.textColor = [UIColor lightGrayColor];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.textColor = [UIColor redColor];
    _statusLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _imgView = [[UIImageView alloc] init];
    
    _titlelabel = [[UILabel alloc] init];
    _titlelabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _peopleLabel = [[UILabel alloc] init];
    _peopleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _hourglassImgView = [[UIImageView alloc] init];
    [_hourglassImgView setImage:[UIImage imageNamed:@"daojishi"]];
    
    _hourglassLabel = [[UILabel alloc] init];
    _hourglassLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _hourglassLabel.textColor = [UIColor lightGrayColor];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"huangkuang"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_rightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_orderNumberLabel];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_statusLabel];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titlelabel];
    [self.contentView addSubview:_peopleLabel];
    [self.contentView addSubview:_hourglassImgView];
    [self.contentView addSubview:_hourglassLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_leftBtn];
    [self.contentView addSubview:_rightBtn];
}
-(void)addConstraints {
    
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(25));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(36));
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNumberLabel.mas_left);
        make.top.equalTo(_orderNumberLabel.mas_bottom).with.offset(5);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(36));
        make.top.equalTo(self.contentView).with.offset(Height_Pt(40));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).with.offset(Height_Pt(25));
        make.left.and.right.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, Width_Pt(36), 0, Width_Pt(36)));
        make.height.mas_equalTo(.5);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(line.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(257), Height_Pt(257)));
    }];
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(Height_Pt(33));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(77));
    }];
    
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titlelabel.mas_bottom).with.offset(Height_Pt(68));
        make.left.equalTo(_titlelabel.mas_left);
    }];
    
    [_hourglassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(36));
        make.centerY.equalTo(_peopleLabel);
    }];
    
    [_hourglassImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hourglassLabel);
        make.right.equalTo(_hourglassLabel.mas_left).with.offset( - 5);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(33), Height_Pt(42)));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom).with.offset(Height_Pt(50));
        make.left.equalTo(_peopleLabel.mas_left);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom).with.offset(Height_Pt(40));
        make.centerX.equalTo(line);
        make.size.equalTo(line);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).with.offset(Height_Pt(30));
        make.right.equalTo(line1.mas_right);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(310), Height_Pt(100)));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(30));
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightBtn.mas_left).with.offset( - Width_Pt(33));
        make.centerY.equalTo(_rightBtn);
        make.size.equalTo(_rightBtn);
    }];
    
}

-(void)buttonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickedAtIndex:)]) {
        [self.delegate didClickedAtIndex:[self.buttonTitles indexOfObject:sender.currentTitle]];
    }
}

@end
