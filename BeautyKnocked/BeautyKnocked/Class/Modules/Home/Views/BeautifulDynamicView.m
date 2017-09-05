//
//  BeautifulDynamicView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeautifulDynamicView.h"
#import "DynamicModel.h"
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
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
    NSMutableArray *addArray=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in dataArray) {
        DynamicModel *model=[DynamicModel mj_objectWithKeyValues:dict];
        
        
        
        
        
       
        NSString *addString=[NSString stringWithFormat:@"用户%@ %@分钟前 预约了%@",[model.account stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"],model.minue,model.name];
        [addArray addObject:addString];
    }
    if (addArray.count!=0) {
        _textBannerView.titlesGroup = addArray;
        [_imgView setImage:[UIImage imageNamed:@"meilidongtai_03"]];
        _BlackSpots.backgroundColor  = [UIColor grayColor];
    }
}
-(NSString *)getCountDownStringWithEndTime:(NSString *)endTime {
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//设置时区
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *localDate = [now dateByAddingTimeInterval: interval];
    
    
    NSTimeInterval endInterval=[[endTime substringToIndex:10] doubleValue];
    

    return nil;
}
-(void)createViews {
    _imgView = [[UIImageView alloc] init];
    
    [self addSubview:_imgView];
    
    _BlackSpots = [[UIView alloc] init];
    
    [_BlackSpots makeCornerRadius:2.5];
    [self addSubview:_BlackSpots];
    
    _textBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    _textBannerView.autoScrollTimeInterval = 4.f;
    _textBannerView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _textBannerView.onlyDisplayText = YES;
    _textBannerView.titleLabelBackgroundColor = [UIColor whiteColor];
    _textBannerView.titleLabelTextFont = [UIFont systemFontOfSize:Font_Size(36)];
    _textBannerView.titleLabelTextColor = [UIColor blackColor];
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
