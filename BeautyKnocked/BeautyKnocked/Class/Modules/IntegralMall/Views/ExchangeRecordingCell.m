//
//  ExchangeRecordingCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeRecordingCell.h"
#import "CouponImageView.h"

@interface ExchangeRecordingCell ()

@property (nonatomic, strong) CouponImageView *couponImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ExchangeRecordingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    
    _couponImageView = [[CouponImageView alloc]init];
    [_couponImageView setImage:[UIImage imageNamed:@"youhuiquan1"]];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(55)];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_couponImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_contentLabel];
    
    _couponImageView.productName = @"白面膜";
    _couponImageView.offset = @"98";
    
    _titleLabel.text = @"98元产品优惠券";
    _contentLabel.text = @"∙仅限购买白面膜\n∙具体操作可在优惠券页面查看";
}

-(void)addConstraints {
    
    [_couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(75));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(36));
        make.width.mas_equalTo(Width_Pt(412));
        make.height.mas_equalTo(Height_Pt(215));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(80));
        make.left.equalTo(_couponImageView.mas_right).with.offset(Width_Pt(60));
        make.height.mas_equalTo(Height_Pt(55));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(38));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(70));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(80));
    }];
}

@end
