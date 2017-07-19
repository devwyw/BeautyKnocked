//
//  FightGroupsView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupsView.h"
#import "UIButton+Category.h"

@interface FightGroupsView ()

@property (nonatomic, strong) UILabel *groupsLabel;

@property (nonatomic, strong) UIButton *allGroupsBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *waitGroup;

@property (nonatomic, strong) UIButton *successGroup;

@property (nonatomic, strong) UIButton *failGroup;

@end

@implementation FightGroupsView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    
    _groupsLabel = [[UILabel  alloc] init];
    _groupsLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _groupsLabel.text = @"我的拼团";
    [self addSubview:_groupsLabel];
    
    _allGroupsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_allGroupsBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    UIImage *moreImage = [UIImage imageNamed:@"gengduo"];
    [_allGroupsBtn setImage:moreImage forState:UIControlStateNormal];
    [_allGroupsBtn setImgViewStyle:ButtonImgViewStyleRight imageSize:moreImage.size space:5];
    _allGroupsBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_allGroupsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_allGroupsBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
    
    _waitGroup = [self setupCustomBtnWtihImageName:@"daichengtuan_03" title:@"待成团"];
    [self addSubview:_waitGroup];
    
    _successGroup = [self setupCustomBtnWtihImageName:@"success_05" title:@"拼团成功"];
    [self addSubview:_successGroup];
    
    _failGroup = [self setupCustomBtnWtihImageName:@"fail_05" title:@"拼团失败"];
    [self addSubview:_failGroup];
}

-(void)setupConstraints {
    
    [_groupsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(Width_Pt(36));
        make.height.mas_equalTo(Height_Pt(87));
    }];
    
    [_allGroupsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_groupsLabel);
        make.right.equalTo(self).with.offset(-Width_Pt(36));
        make.height.equalTo(_groupsLabel.mas_height);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_groupsLabel.mas_bottom).with.offset(5);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    NSArray *views = @[_waitGroup,_successGroup,_failGroup];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
    }];
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
}

-(UIButton *)setupCustomBtnWtihImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageOriginalImageName:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleTop imageSize:image.size space:6];
    return button;
}

@end
