//
//  FightingGroupCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightingGroupCell.h"
#import "UIButton+Category.h"

@interface FightingGroupCell ()

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *needPeopleLabel;
@property (nonatomic, strong) UILabel *overtimeLabel;
@property (nonatomic, strong) UIButton *joinGroupBtn;
@property (nonatomic, strong) UIView *backView;

@end

@implementation FightingGroupCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setImgName:(NSString *)imgName {
    [_headImgView setImage:[UIImage imageNamed:imgName]];
}
-(void)setNickName:(NSString *)nickName {
    _nickLabel.text = nickName;
}
-(void)setNeedPeople:(NSString *)needPeople {
    _needPeopleLabel.text = needPeople;
}
-(void)setTelNumber:(NSString *)telNumber {
    _telLabel.text = telNumber;
}
-(void)setOvertime:(NSString *)overtime {
    _overtimeLabel.text = overtime;
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
    
    _headImgView = [[UIImageView alloc] init];
    [_headImgView setImage:[UIImage imageNamed:@"touxiang2"]];
    
    _nickLabel = [[UILabel alloc] init];
    _nickLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _needPeopleLabel = [[UILabel alloc] init];
    _needPeopleLabel.textColor = [UIColor redColor];
    _needPeopleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.font = [UIFont systemFontOfSize:Font_Size(30)];
    _telLabel.textColor = [UIColor lightGrayColor];
    
    _overtimeLabel = [[UILabel alloc] init];
    _overtimeLabel.font = [UIFont systemFontOfSize:Font_Size(30)];
    _overtimeLabel.textColor = [UIColor lightGrayColor];
    
    _joinGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_joinGroupBtn setTitle:@"去参团" forState:UIControlStateNormal];
    _joinGroupBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    UIImage *goImage = [UIImage imageNamed:@"cantuan"];
    [_joinGroupBtn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [_joinGroupBtn setImage:goImage forState:UIControlStateNormal];
    [_joinGroupBtn setImgViewStyle:ButtonImgViewStyleRight imageSize:goImage.size space:3];
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    [self.contentView addSubview:_backView];
    [self.contentView addSubview:_headImgView];
    [self.contentView addSubview:_joinGroupBtn];
    [_backView addSubview:_nickLabel];
    [_backView addSubview:_needPeopleLabel];
    [_backView addSubview:_telLabel];
    [_backView addSubview:_overtimeLabel];
    
}

-(void)addConstraints {
    
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(30));
        make.centerY.equalTo(self.contentView);
        //make.size.mas_equalTo(CGSizeMake(Width_Pt(168), Height_Pt(168)));
        make.top.equalTo(self.contentView).with.offset(12);
        make.bottom.equalTo(self.contentView).with.offset(-12);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_headImgView.mas_right).with.offset( - Width_Pt(40));
        make.height.mas_equalTo(Height_Pt(136));
    }];
    
    [_joinGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_backView.mas_right).with.offset( - 1);
        make.right.equalTo(self.contentView).with.offset( - 8);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(215), Height_Pt(136)));
    }];
    
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).with.offset(Width_Pt(50));
        make.top.equalTo(_backView).with.offset(Height_Pt(20));
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLabel.mas_bottom).with.offset(Height_Pt(20));
        make.left.equalTo(_nickLabel.mas_left);
        make.bottom.equalTo(_backView).with.offset( - Height_Pt(20));
    }];
    
    [_needPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nickLabel);
        make.right.equalTo(_backView).with.offset( - Width_Pt(30));
    }];
    
    [_overtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_telLabel);
        make.right.equalTo(_backView).with.offset( - Width_Pt(30));
    }];
    
}
@end
