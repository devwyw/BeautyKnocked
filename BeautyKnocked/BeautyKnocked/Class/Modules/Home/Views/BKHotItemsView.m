//
//  BKHotItemsView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BKHotItemsView.h"
#import "MenuItemView.h"
#import "ItemTitleView.h"

@interface BKHotItemsView ()

@property (nonatomic, strong) ItemTitleView *titleView;

@property (nonatomic, strong) UIView *lineViw;

@property (nonatomic, strong) MenuItemView *menuItemView;

@property (nonatomic,strong) id Fself;

@end

@implementation BKHotItemsView

-(instancetype)initWithFrame:(CGRect)frame andFself:(id)Fself{
    self = [super initWithFrame:frame];
    if (self) {
        _Fself=Fself;
        [self createInterface];
        [self configureConstraints];
    }
    return self;
}

-(void)createInterface {
    
    _titleView = [[ItemTitleView alloc] init];
    _titleView.titleFont = [UIFont systemFontOfSize:Font_Size(45)];
    _titleView.leftImageName = @"remen_03";
    _titleView.titleName = @"热门项目";
    [self addSubview:_titleView];
    
    _lineViw = [[UIView alloc] init];
    _lineViw.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineViw];

    _menuItemView = [[MenuItemView alloc] init];
    [_menuItemView setMtag:1];
    [_menuItemView setDelegate:_Fself];
    _menuItemView.itemSize = CGSizeMake((Width - Width_Pt(142) * 3 - Width_Pt(66) * 2) / 4, Height_Pt(187));
    _menuItemView.cellEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    _menuItemView.interitemSpacing = Height_Pt(142);
    _menuItemView.dataArray = @[@{@"image":@"meijia_03",@"title":@"上门美甲"},
                                @{@"image":@"meirong_03",@"title":@"上门美容"},
                                @{@"image":@"meifa_03",@"title":@"上门美发"},
                                @{@"image":@"gaungdian_03",@"title":@"光电中心"},
                                @{@"image":@"liaocheng_03",@"title":@"疗程套餐"},
                                @{@"image":@"shangcheng_03",@"title":@"商城"},
                                @{@"image":@"huiyaun_03",@"title":@"会员充值"},
                                @{@"image":@"jishi_03",@"title":@"附近技师"}];
    
    _menuItemView.imgeViewSize =  CGSizeMake(Width_Pt(100), Height_Pt(100));
    _menuItemView.topDistance = Height_Pt(27);
    _menuItemView.middleDistance = Height_Pt(20);
    _menuItemView.bottomDistance = Height_Pt(15);
    _menuItemView.titleFont = [UIFont systemFontOfSize:Font_Size(42)];
    
    [self addSubview:_menuItemView];
}

-(void)configureConstraints {
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(18));
        make.width.mas_equalTo(Width_Pt(200));
        make.height.mas_equalTo(Height_Pt(80));
    }];
    
    [_lineViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_menuItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineViw.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self);
    }];
    
}

@end
