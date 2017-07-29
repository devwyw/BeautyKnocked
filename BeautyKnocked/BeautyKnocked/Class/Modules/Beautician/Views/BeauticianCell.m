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
/**
 head icon
 */
@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *verticalLine;

@property (nonatomic, strong) UIImageView *horizonLine;

@property (nonatomic, strong) UILabel *collectionLabel;

/**
 collection count
 */
@property (nonatomic, strong) UILabel *collectionCount;

@property (nonatomic, strong) UILabel *scoreLabel;

/**
 score number
 */
@property (nonatomic, strong) UILabel *scoreNumber;

@property (nonatomic, strong) UILabel *descrLabel;

/**
 collect button
 */
@property (nonatomic, strong) UIButton *collectBtn;

/**
 reserve button
 */
@property (nonatomic, strong) UIButton *reserveBtn;

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
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self setupCellInterface];
        [self configureConstraints];
        
    }
    return self;
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
    [_headImgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    [self.backView addSubview:_headImgView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"刘亦菲";
    [self.backView addSubview:_nameLabel];
    
    _verticalLine = [[UIImageView alloc] init];
    [_verticalLine setImage:[UIImage imageNamed:@"xian2_15"]];
    [self.backView addSubview:_verticalLine];
    
    _horizonLine = [[UIImageView alloc] init];
    [_horizonLine setImage:[UIImage imageNamed:@"xian3_19"]];
    [self.backView addSubview:_horizonLine];
    
    _collectionLabel = [[UILabel alloc] init];
    _collectionLabel.font = [UIFont systemFontOfSize:13];
    _collectionLabel.textColor = [UIColor lightGrayColor];
    _collectionLabel.text = @"总收藏数";
    [self.backView addSubview:_collectionLabel];
    
    _collectionCount = [[UILabel alloc] init];
    _collectionCount.font = [UIFont systemFontOfSize:10];
    _collectionCount.text = @"55";
    _collectionCount.textColor = [UIColor redColor];
    [self.backView addSubview:_collectionCount];
    
    _scoreLabel = [[UILabel alloc] init];
    _scoreLabel.font = [UIFont systemFontOfSize:13];
    _scoreLabel.textColor = [UIColor lightGrayColor];
    _scoreLabel.text = @"总评分";
    [self.backView addSubview:_scoreLabel];
    
    _scoreNumber = [[UILabel alloc] init];
    _scoreNumber.font = [UIFont systemFontOfSize:10];
    _scoreNumber.textColor = [UIColor redColor];
    _scoreNumber.text = @"5.0";
    [self.backView addSubview:_scoreNumber];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.numberOfLines = 0;
    _descrLabel.font = [UIFont systemFontOfSize:15];
    _descrLabel.text = @"本人从事美容1000年,擅长各种美容,能把丑女变美女,能让仙女变巫婆,能让男人变女人,能让女人变男人,找我,一切都不是问题,请拨打123466498778";
    [self.backView addSubview:_descrLabel];
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_collectBtn setTitle:@"收藏美容师" forState:UIControlStateNormal];
    _collectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_collectBtn setBackgroundImage:[UIImage imageNamed:@"shoucangkuang_19"] forState:UIControlStateNormal];
    [self.backView addSubview:_collectBtn];
    
    _reserveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reserveBtn setBackgroundImage:[UIImage imageNamed:@"yuyuekuang_19"] forState:UIControlStateNormal];
    [_reserveBtn setTitle:@"预约美容师" forState:UIControlStateNormal];
    _reserveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.backView addSubview:_reserveBtn];
    
    // event
    [[_reserveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([self.delegate respondsToSelector:@selector(reserveBeautician)]) {
            [self.delegate reserveBeautician];
        }
    }];
    
    
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
    
    // beautician decrible
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_horizonLine.mas_bottom).with.offset(Height_Pt(33));
        make.left.equalTo(_horizonLine.mas_left);
        make.right.equalTo(_horizonLine.mas_right);
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descrLabel.mas_bottom).with.offset(Height_Pt(33));
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
    
}

-(void)setNumber:(NSUInteger)number {
    _numberLabel.text = [NSString stringWithFormat:@"%02lu",(unsigned long)number];
}

@end
