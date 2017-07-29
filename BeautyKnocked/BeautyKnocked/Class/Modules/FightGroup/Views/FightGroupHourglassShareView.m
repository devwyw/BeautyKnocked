//
//  FightGroupHourglassShareView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupHourglassShareView.h"
#import "UIButton+Category.h"

@interface FightGroupHourglassShareView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *hourglassLabel;
@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) UIButton *wchatShare;
@property (nonatomic, strong) UIButton *friendShare;
@property (nonatomic, strong) UIButton *QQShare;
@property (nonatomic, strong) UIButton *sinaShare;
@end

@implementation FightGroupHourglassShareView

-(void)setHourglass:(NSAttributedString *)hourglass {
    _hourglassLabel.attributedText = hourglass;
}
-(void)setPeople:(NSAttributedString *)people {
    _peopleLabel.attributedText = people;
}

-(void)setTextColor:(UIColor *)textColor {
    _titleLabel.textColor = textColor;
    _hourglassLabel.textColor = textColor;
    _peopleLabel.textColor = textColor;
    [_wchatShare setTitleColor:textColor forState:UIControlStateNormal];
    [_friendShare setTitleColor:textColor forState:UIControlStateNormal];
    [_QQShare setTitleColor:textColor forState:UIControlStateNormal];
    [_sinaShare setTitleColor:textColor forState:UIControlStateNormal];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _hourglassLabel = [[UILabel alloc] init];
    _hourglassLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _peopleLabel = [[UILabel alloc] init];
    _peopleLabel.font = [UIFont systemFontOfSize:Font_Size(60)];
    
    _wchatShare = [self createShareButtonWithImageName:@"weixin2" title:@"微信好友"];
    _friendShare = [self createShareButtonWithImageName:@"pengyouquan" title:@"朋友圈"];
    _QQShare = [self createShareButtonWithImageName:@"QQ-" title:@"QQ好友"];
    _sinaShare = [self createShareButtonWithImageName:@"weibo" title:@"微博"];
    
    _wchatShare.tag = 1200;
    _friendShare.tag = 1201;
    _QQShare.tag = 1202;
    _sinaShare.tag = 1203;
    
    [_wchatShare addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_friendShare addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_QQShare addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_sinaShare addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_titleLabel];
    [self addSubview:_hourglassLabel];
    [self addSubview:_peopleLabel];
    
    [self addSubview:_wchatShare];
    [self addSubview:_friendShare];
    [self addSubview:_QQShare];
    [self addSubview:_sinaShare];
    
    _titleLabel.text = @"距离拼团结束还有";
    
}
-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(40));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_hourglassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(58));
        make.height.mas_equalTo(Height_Pt(80));
    }];
    
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_hourglassLabel.mas_bottom).with.offset(Height_Pt(145));
        make.height.mas_equalTo(Height_Pt(60));
    }];
    
    NSArray *views = @[_wchatShare,_friendShare,_QQShare,_sinaShare];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom).with.offset(Height_Pt(70));
        make.height.mas_equalTo(Height_Pt(170));
    }];
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:Width_Pt(160) leadSpacing:Width_Pt(100) tailSpacing:Width_Pt(100)];
    
}

-(void)shareButtonClicked:(UIButton *)sender {
    if (self.FightGroupShareBlock) {
        self.FightGroupShareBlock(sender.tag - 1200);
    }
}

-(UIButton *)createShareButtonWithImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleTop imageSize:image.size space:Width_Pt(35)];
    return button;
}

@end
