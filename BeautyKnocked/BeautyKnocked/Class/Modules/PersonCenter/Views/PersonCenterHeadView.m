//
//  PersonCenterHeadView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PersonCenterHeadView.h"
#import "FightGroupsView.h"
#import "UIButton+Category.h"
#import "UIImage+Original.h"

@interface PersonCenterHeadView ()

@property (nonatomic, strong) UIButton *setupButton;

@property (nonatomic, strong) UIButton *messageButton;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic,strong) UIButton *headIconBtn;
@property (nonatomic,strong) UIImageView * headIcon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *balanceBtn;
@property (nonatomic,strong) UIButton *levelBtn;
@property (nonatomic,strong) UIButton *couponBtn;
@property (nonatomic,strong) UILabel *groupsLabel;
@property (nonatomic,strong) UIButton *allGroupsBtn;
@property (nonatomic,strong) UIButton *waitGroup;
@property (nonatomic,strong) UIButton *successGroup;
@property (nonatomic,strong) UIButton *failGroup;
@property (nonatomic,strong) Acount * user;
@end

@implementation PersonCenterHeadView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(Acount*)user{
    if (!_user) {
        _user=[Acount shareManager];
    }
    return _user;
}
-(void)getUserData{
    _nameLabel.text = self.user.account;
    [Master GetWebImage:_headIcon withUrl:self.user.headPath];
}
-(void)setupInterface {
    _backImgView = [[UIImageView alloc] init];
    _backImgView.image = [UIImage imageNamed:@"top-bj_01"];
    _backImgView.userInteractionEnabled = YES;
    [self addSubview:_backImgView];
    
    _setupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_setupButton setImage:[UIImage imageOriginalImageName:@"shezhi"] forState:UIControlStateNormal];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageButton setImage:[UIImage imageOriginalImageName:@"xiaoxi"] forState:UIControlStateNormal];
    
    _headIconBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _headIcon=[[UIImageView alloc]init];
    [_headIcon setContentMode:UIViewContentModeScaleAspectFill];
    [_headIcon setClipsToBounds:YES];
    [_headIcon makeCornerRadius:Width_Pt(228)/2];
    [Master GetWebImage:_headIcon withUrl:self.user.headPath];
    [_headIconBtn addSubview:_headIcon];

    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = [Acount shareManager].account;
    _nameLabel.font = [UIFont systemFontOfSize:15];

    _balanceBtn = [self setupCustomBtnWtihImageName:@"yue_03" title:@"余额"];
    _levelBtn = [self setupCustomBtnWtihImageName:@"VIP_03" title:@"等级"];
    _couponBtn = [self setupCustomBtnWtihImageName:@"youhuiquan_03" title:@"优惠券"];
    
    [_balanceBtn addTarget:self action:@selector(itemButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_levelBtn addTarget:self action:@selector(itemButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_couponBtn addTarget:self action:@selector(itemButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _balanceBtn.tag = 1060;
    _levelBtn.tag = 1061;
    _couponBtn.tag = 1062;
    
    [self.backImgView addSubview:_setupButton];
    [self.backImgView addSubview:_messageButton];
    [self.backImgView addSubview:_headIconBtn];
    [self.backImgView addSubview:_nameLabel];
    [self.backImgView addSubview:_balanceBtn];
    [self.backImgView addSubview:_levelBtn];
    [self.backImgView addSubview:_couponBtn];
    
    
    // group view
    _groupsLabel = [[UILabel  alloc] init];
    _groupsLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _groupsLabel.text = @"我的拼团";
    
    
    _allGroupsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_allGroupsBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    UIImage *moreImage = [UIImage imageNamed:@"gengduo"];
    [_allGroupsBtn setImage:moreImage forState:UIControlStateNormal];
    [_allGroupsBtn setImgViewStyle:ButtonImgViewStyleRight imageSize:moreImage.size space:5];
    _allGroupsBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_allGroupsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _waitGroup = [self setupCustomBtnWtihImageName:@"daichengtuan_03" title:@"待成团"];
    
    _successGroup = [self setupCustomBtnWtihImageName:@"success_05" title:@"拼团成功"];
    
    _failGroup = [self setupCustomBtnWtihImageName:@"fail_05" title:@"拼团失败"];
    
    _allGroupsBtn.tag = 1050;
    _waitGroup.tag = 1051;
    _successGroup.tag = 1052;
    _failGroup.tag = 1053;
    
    [_allGroupsBtn addTarget:self action:@selector(groupButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_waitGroup addTarget:self action:@selector(groupButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_successGroup addTarget:self action:@selector(groupButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [_failGroup addTarget:self action:@selector(groupButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_groupsLabel];
    [self addSubview:_allGroupsBtn];
    [self addSubview:_waitGroup];
    [self addSubview:_successGroup];
    [self addSubview:_failGroup];
    
    // Event
    [[_headIconBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([self.delegate respondsToSelector:@selector(headIconDidClicked)]) {
            [self.delegate headIconDidClicked];
        }
    }];
}
-(void)setupConstraints {
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(682));
    }];
    
    [_setupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backImgView).with.offset( - Width_Pt(46));
        make.top.equalTo(_backImgView).offset(Height_Pt(85));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(70), Height_Pt(70)));
    }];
    
    [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_setupButton);
        make.left.equalTo(_backImgView).with.offset(Width_Pt(46));
        make.size.equalTo(_setupButton);
    }];
    
    [_headIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImgView).with.offset(Height_Pt(121.f));
        make.centerX.equalTo(_backImgView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(228), Height_Pt(228)));
    }];
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_headIconBtn);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIconBtn.mas_bottom).with.offset(Height_Pt(20.f));
        make.centerX.equalTo(_backImgView);
    }];
    
    NSArray *views = @[_balanceBtn,_levelBtn,_couponBtn];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(Height_Pt(100));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(80), Height_Pt(110)));
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:Width_Pt(115) leadSpacing:Width_Pt(219) tailSpacing:Width_Pt(219)];
    
    // groupView
    
    [_groupsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImgView.mas_bottom);
        make.left.equalTo(self).with.offset(Width_Pt(36));
        make.height.mas_equalTo(Height_Pt(87));
    }];
    
    [_allGroupsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_groupsLabel);
        make.right.equalTo(self).with.offset(-Width_Pt(36));
        make.height.equalTo(_groupsLabel.mas_height);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_groupsLabel.mas_bottom).with.offset(5);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    NSArray *views1 = @[_waitGroup,_successGroup,_failGroup];
    
    [views1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
    }];
    
    [views1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
}

-(UIButton *)setupCustomBtnWtihImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:35/3.f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageOriginalImageName:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleTop imageSize:image.size space:5];
    return button;
}

-(RACSignal *)setClickedSignal {
    return [_setupButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

-(RACSignal *)messageClickedSignal {
    return [_messageButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

-(void)groupButtonclicked:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(didGroupClicked:)]) {
        [self.delegate didGroupClicked:button.tag-1050];
    }
    
}

-(void)itemButtonclicked:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(didSelectedItemAtIndex:)]) {
        [self.delegate didSelectedItemAtIndex:button.tag-1060];
    }
    
}

@end
