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
        NSString *addString=[NSString stringWithFormat:@"用户%@ 在%@前 预约了%@",[model.account stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"],[self getCountDownStringWithEndTime:model.createDate],model.name];
        [addArray addObject:addString];
    }
    if (addArray.count!=0) {
        _textBannerView.titlesGroup = addArray;
        [_imgView setImage:[UIImage imageNamed:@"meilidongtai_03"]];
        _BlackSpots.backgroundColor  = [UIColor grayColor];
    }
}
-(NSString *)getCountDownStringWithEndTime:(NSString *)endTime {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //当前时间
    NSDate *nowDate = [NSDate date];
    //结束时间
    NSTimeInterval endInterval=[[endTime substringToIndex:10] doubleValue];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endInterval];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:endDate toDate:nowDate options:0];
    NSString *time=nil;
    if (dateCom.day>=1) {
        time=@"一天";
    }else if (dateCom.hour>=1) {
        time=[NSString stringWithFormat:@"%ld小时",dateCom.hour];
    }else if (dateCom.minute>=1){
        time=[NSString stringWithFormat:@"%ld分钟",dateCom.minute];
    }else if (dateCom.second>=1){
        time=[NSString stringWithFormat:@"%ld秒",dateCom.second];
    }
    return time;
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
