//
//  ConfirmOrderProductCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderProductCell.h"
#import "ProductModel.h"
#import "CountView.h"

@interface ConfirmOrderProductCell ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) CountView * countview;
@end

@implementation ConfirmOrderProductCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setModel:(ProductModel *)model{
    _model=model;
    [Master GetWebImage:_imgView withUrl:model.imagePath];
    _titleLabel.text=model.name;
    _priceLabel.text=[NSString stringWithFormat:@"¥ %@",model.price];
    if (isStringEmpty(model.count)) {
        _countview.counts=@"1";
    }else{
        _countview.counts=model.count;
    }
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
    _imgView = [[UIImageView alloc] init];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_priceLabel];
    
    _countview=[[CountView alloc]init];
    _countview.subCounts=[RACSubject subject];
    [_countview.subCounts subscribeNext:^(id  _Nullable x) {
        _countview.counts=x;
        [_subCount sendNext:_countview.counts];
    }];
    [self.contentView addSubview:_countview];
}
-(void)addConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(8);
        make.left.equalTo(self.contentView).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(240), Height_Pt(240)));
        make.bottom.equalTo(self.contentView).with.offset( - 8);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).with.offset(8);
        make.top.equalTo(_imgView.mas_top).with.offset(8);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.bottom.equalTo(_imgView.mas_bottom).with.offset(- 8);
    }];
    
    [_countview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-Width_Pt(40));
        make.centerY.equalTo(_priceLabel);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(260), Height_Pt(70)));
    }];
}
@end
