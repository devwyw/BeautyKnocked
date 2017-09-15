//
//  BeauticianCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianCell.h"

@interface BeauticianCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *verticalLine;
@property (nonatomic, strong) UIImageView *horizonLine;
@property (nonatomic, strong) UILabel *collectionLabel;
@property (nonatomic, strong) UILabel *collectionCount;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *scoreNumber;

@property (nonatomic, strong) UILabel *descrLabel;

@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *reserveBtn;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation BeauticianCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        [self setupCellInterface];
        [self configureConstraints];
    }
    return self;
}
-(void)setIsCancel:(BOOL)isCancel{
    if (isCancel) {
        [_collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        _collectBtn.userInteractionEnabled=YES;
    }
}
-(void)setModel:(BeauticianModel *)model{
    _model=model;
    [Master GetWebImage:_headImgView withUrl:model.headPath];
    _numberLabel.text=model.id;
    _nameLabel.text = model.name;
    _collectionCount.text = model.collects;
    _scoreNumber.text = model.score;
    _descrLabel.text = model.introduce;
    if ([model.isCollect integerValue]==1) {
        [_collectBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        _collectBtn.userInteractionEnabled=NO;
    }else{
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_collectBtn setTitle:@"收藏美容师" forState:UIControlStateNormal];
        _collectBtn.userInteractionEnabled=YES;
    }
}
-(void)setIsBeauticianSelect:(BOOL)isBeauticianSelect{
    _isBeauticianSelect=isBeauticianSelect;
    if (_isBeauticianSelect) {
        _selectedBtn.hidden=!_isBeauticianSelect;
        _collectBtn.hidden=_isBeauticianSelect;
        _reserveBtn.hidden=_isBeauticianSelect;
    }
}
-(void)setupCellInterface {
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backView];
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"meirongsbj_11"]];
    [self.backView addSubview:_imgView];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_imgView addSubview:_numberLabel];
    
    _headImgView = [[UIImageView alloc] init];
    [_headImgView makeCornerRadius:Width_Pt(80.5)];
    [_headImgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    [self.backView addSubview:_headImgView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.backView addSubview:_nameLabel];
    
    _verticalLine = [[UIImageView alloc] init];
    [_verticalLine setImage:[UIImage imageNamed:@"xian2_15"]];
    [self.backView addSubview:_verticalLine];
    
    _horizonLine = [[UIImageView alloc] init];
    [_horizonLine setImage:[UIImage imageNamed:@"xian3_19"]];
    [self.backView addSubview:_horizonLine];
    
    _collectionLabel = [[UILabel alloc] init];
    _collectionLabel.font = [UIFont systemFontOfSize:13];
    _collectionLabel.textColor = [UIColor darkGrayColor];
    _collectionLabel.text = @"总收藏数";
    [self.backView addSubview:_collectionLabel];
    
    _collectionCount = [[UILabel alloc] init];
    _collectionCount.font = [UIFont systemFontOfSize:10];
    _collectionCount.textColor = [UIColor redColor];
    [self.backView addSubview:_collectionCount];
    
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.font = [UIFont systemFontOfSize:13];
    _scoreLabel.textColor = [UIColor darkGrayColor];
    _scoreLabel.text = @"总评分";
    [self.backView addSubview:_scoreLabel];
    
    _scoreNumber = [[UILabel alloc] init];
    _scoreNumber.font = [UIFont systemFontOfSize:10];
    _scoreNumber.textColor = [UIColor redColor];
    [self.backView addSubview:_scoreNumber];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.numberOfLines = 0;
    _descrLabel.font = [UIFont systemFontOfSize:15];
    [self.backView addSubview:_descrLabel];
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_collectBtn setBackgroundImage:[UIImage imageNamed:@"shoucangkuang_19"] forState:UIControlStateNormal];
    [self.backView addSubview:_collectBtn];
    
    _reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reserveBtn setBackgroundImage:[UIImage imageNamed:@"yuyuekuang_19"] forState:UIControlStateNormal];
    [_reserveBtn setTitle:@"预约美容师" forState:UIControlStateNormal];
    _reserveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.backView addSubview:_reserveBtn];
    
    _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"yuyuekuang_19"] forState:UIControlStateNormal];
    [_selectedBtn setTitle:@"选择美容师" forState:UIControlStateNormal];
    _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _selectedBtn.hidden=YES;
    [self.backView addSubview:_selectedBtn];
}
-(RACSignal*)collect{
    return [_collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)reserve{
    return [_reserveBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)beaSelect{
    return [_selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(void)configureConstraints {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(30.f);
        make.left.equalTo(self.contentView).with.offset(7.f);
        make.right.equalTo(self.contentView).with.offset(-7.f);
        make.bottom.equalTo(self.contentView);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.left.equalTo(_backView).with.offset(Width_Pt(56));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(100), Height_Pt(144)));
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(_imgView);
    }];
    
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_backView).with.offset(-Height_Pt(81));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(161), Height_Pt(161)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImgView.mas_bottom).with.offset(Height_Pt(39));
        make.centerX.equalTo(_backView);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(81));
        make.width.mas_equalTo(1.f);
        make.height.mas_equalTo(Height_Pt(122));
    }];
    
    [_collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verticalLine.mas_top).with.offset(Height_Pt(9));
        make.right.equalTo(_verticalLine.mas_left).with.offset( - Width_Pt(147));
        make.height.mas_equalTo(Height_Pt(39));
    }];
    
    [_collectionCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_collectionLabel);
        make.top.equalTo(_collectionLabel.mas_bottom).with.offset(Height_Pt(27));
        make.height.mas_equalTo(Height_Pt(30));
    }];
    
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_collectionLabel);
        make.left.equalTo(_verticalLine.mas_right).with.offset(Width_Pt(147));
        make.height.equalTo(_collectionLabel);
    }];
    
    [_scoreNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scoreLabel);
        make.top.equalTo(_scoreLabel.mas_bottom).with.offset(Height_Pt(27));
        make.height.equalTo(_collectionCount);
    }];
    
    [_horizonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verticalLine.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_backView).with.offset(37);
        make.right.equalTo(_backView).with.offset( - Width_Pt(111));
        make.height.mas_equalTo(Height_Pt(8));
    }];
    
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_horizonLine.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_horizonLine.mas_left);
        make.right.equalTo(_horizonLine.mas_right);
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descrLabel.mas_bottom).with.offset(Height_Pt(30));
        make.left.and.bottom.equalTo(_backView);
        make.bottom.equalTo(_backView);
        make.width.equalTo(_reserveBtn);
        make.height.mas_equalTo(Height_Pt(120));
    }];
    
    [_reserveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectBtn.mas_right);
        make.right.and.bottom.equalTo(_backView);
        make.centerY.equalTo(_collectBtn);
        make.height.equalTo(_collectBtn);
    }];
    
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_descrLabel.mas_bottom).offset(Height_Pt(30));
        make.bottom.equalTo(_backView).offset(-Height_Pt(30));
        make.width.offset(Width/3);
        make.height.offset(Height_Pt(200));
    }];
}
@end
