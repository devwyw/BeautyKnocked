//
//  BeautifulDynamicView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeautifulDynamicView.h"
#import <SDCycleScrollView.h>

@interface BeautifulDynamicView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIView *BlackSpots;

@property (nonatomic, strong) SDCycleScrollView *textBannerView;

@end

@implementation BeautifulDynamicView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self addConstraints];
    }
    return self;
}

-(void)createViews {
    
    _imgView = [[UIImageView alloc] init];
    [_imgView setImage:[UIImage imageNamed:@"meilidongtai_03"]];
    [self addSubview:_imgView];
    
    _BlackSpots = [[UIView alloc] init];
    _BlackSpots.backgroundColor  = [UIColor grayColor];
    _BlackSpots.layer.cornerRadius = 2.5;
    [self addSubview:_BlackSpots];
    
    _textBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    _textBannerView.autoScrollTimeInterval = 4.f;
    _textBannerView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _textBannerView.onlyDisplayText = YES;
    _textBannerView.titleLabelBackgroundColor = [UIColor whiteColor];
    _textBannerView.titleLabelTextFont = [UIFont systemFontOfSize:Font_Size(36)];
    _textBannerView.titleLabelTextColor = [UIColor blackColor];
    _textBannerView.titlesGroup = @[@"用户178****4567 5分钟前 预约了水美人项目",
                                    @"用户178****4568 1分钟前 预约了水美人项目",
                                    @"用户178****4569 3分钟前 预约了水美人项目",
                                    @"用户178****4560 6分钟前 预约了水美人项目",
                                    @"用户178****4562 8分钟前 预约了水美人项目"];
    [_textBannerView setUserInteractionEnabled:NO];
    [self addSubview:_textBannerView];
    
}

-(void)addConstraints {
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(30));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(83), Height_Pt(66)));
    }];
    
    [_BlackSpots mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(30));
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
    [_textBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.equalTo(self);
        make.left.equalTo(_BlackSpots.mas_right).with.offset(Width_Pt(15));
    }];
    
}

@end
