//
//  ItemCell.m
//  Technician
//
//  Created by Mac on 2017/8/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ItemCell.h"
#import "CountView.h"

@interface ItemCell ()

@property (nonatomic,strong) UIView * white;
@property (nonatomic,strong) UIImageView * anction;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UILabel * price;
@property (nonatomic,strong) UILabel * count;
@property (nonatomic,strong) UIButton * edit;
@property (nonatomic,strong) CountView * countView;
@end

@implementation ItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor clearColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(ShopCarModel *)model{
    _model=model;
    [Master GetWebImage:_image withUrl:model.pv.imagePath];
    _anction.highlighted=model.isSelect;
    _title.text=model.pv.name;
    _price.text=[NSString stringWithFormat:@"¥ %@",model.pv.price];
    _count.text=[NSString stringWithFormat:@"x%@",model.num];
    _edit.selected=model.isEdit;
    [self getStatus:_edit.isSelected];
    if (isStringEmpty(model.count)) {
        _countView.counts=model.num;
    }else{
        _countView.counts=model.count;
    }
}
-(void)initializeViews{
    _white=[[UIView alloc]init];
    _white.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_white];
    
    _anction=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixuanzhong"] highlightedImage:[UIImage imageNamed:@"xuanzhong"]];
    [_white addSubview:_anction];
    
    _image=[[UIImageView alloc]init];
    [_image setContentMode:UIViewContentModeScaleAspectFill];
    [_image setClipsToBounds:YES];
    [_white addSubview:_image];
    
    _title=[[UILabel alloc]init];
    
    _title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_white addSubview:_title];
    
    _price=[[UILabel alloc]init];
    
    _price.textColor=[UIColor colorWithHexString:@"#D83434"];
    _price.font=[UIFont systemFontOfSize:Font_Size(35)];
    [_white addSubview:_price];

    _edit=[[UIButton alloc]init];
    _edit.titleLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_edit setTitle:@"编辑" forState:UIControlStateNormal];
    [_edit setTitle:@"完成" forState:UIControlStateSelected];
    [_edit setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_edit setTitleColor:ThemeColor forState:UIControlStateSelected];
    Weakify(self);
    [[_edit rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIButton *edit=(UIButton*)x;
        edit.selected=!edit.isSelected;
        [_subEdits sendNext:edit.isSelected ? @"1":@"0"];
        [Wself getStatus:edit.isSelected];
        if ([_model.num integerValue]!=[_countView.counts integerValue]) {
            [_subCounts sendNext:_countView.counts];
        }
    }];
    [_white addSubview:_edit];
    
    _count=[[UILabel alloc]init];
    _count.font=[UIFont systemFontOfSize:Font_Size(35)];
    [_white addSubview:_count];
    
    _countView=[[CountView alloc]init];
    _countView.hidden=YES;
    _countView.subCounts=[RACSubject subject];
    [_countView.subCounts subscribeNext:^(id  _Nullable x) {
        _countView.counts=x;
        _count.text=[NSString stringWithFormat:@"x%@",_countView.counts];
        [_subCountViews sendNext:x];
    }];
    [_white addSubview:_countView];
}
-(void)getStatus:(BOOL)status{
    _count.hidden=status;
    _countView.hidden=!status;
}
-(void)addConstraints {
    [_white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
    }];
    
    [_anction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_white);
        make.left.equalTo(_white).offset(Width_Pt(45));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(60), Height_Pt(60)));
    }];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_white);
        make.left.equalTo(_anction.mas_right).offset(Width_Pt(60));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(240), Height_Pt(240)));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image).offset(Height_Pt(20));
        make.left.equalTo(_image.mas_right).offset(Width_Pt(40));
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.bottom.equalTo(_image.mas_bottom).offset(-Height_Pt(20));
    }];
    
    [_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_white).offset(-Width_Pt(40));
        make.centerY.equalTo(_title);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(90), Height_Pt(45)));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_edit);
        make.centerY.equalTo(_price);
    }];
    
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_edit);
        make.centerY.equalTo(_price);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(260), Height_Pt(70)));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
