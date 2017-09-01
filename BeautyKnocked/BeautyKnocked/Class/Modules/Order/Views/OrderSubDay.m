//
//  OrderSubDay.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderSubDay.h"
#import "MLDateCollectionViewCell.h"
#import "MLDateManager.h"
#import "OrderSubTime.h"
#import "TimeSlotModel.h"

static OrderSubDay *instance=nil;

@interface OrderSubDay ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSCopying,NSMutableCopying>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *remarkLabel;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSArray *months;
@property (nonatomic,strong) NSArray *weekDays;

@property (nonatomic,strong) NSDateComponents *nowCompoents;
@property (nonatomic,strong) NSMutableDictionary * cellIdentifierDic;
@property (nonatomic,strong) DayModel * startTime;
@property (nonatomic,strong) NSMutableDictionary * webTimeData;
@end

@implementation OrderSubDay
#pragma mark ===== 单例模式 =====
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (!instance) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}
-(id)copy{
    return self;
}
-(id)mutableCopy{
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}
+(instancetype)shareManager{
    if (!instance) {
        instance = [[OrderSubDay alloc]initWithFrame:CGRectMake(0, 0,Width_Pt(1018), Height_Pt(1186) + 20)];
        [instance makeCornerRadius:5];
        instance.backgroundColor=[UIColor whiteColor];
        [instance initializeViews];
    }
    return instance;
}
-(NSMutableDictionary*)cellIdentifierDic{
    if (!_cellIdentifierDic) {
        _cellIdentifierDic=[[NSMutableDictionary alloc]init];
    }
    return _cellIdentifierDic;
}
-(NSMutableDictionary*)webTimeData{
    if (!_webTimeData) {
        _webTimeData=[[NSMutableDictionary alloc]init];
    }
    return _webTimeData;
}
-(void)setModel:(WebTimeModel *)model{
    _model=model;
    _startTime=[[DayModel alloc]initGetHttpData:_model.startTime];
    [self.webTimeData removeAllObjects];

    for (NSDictionary *dict in _model.list) {
        TimeSlotModel *model=[TimeSlotModel mj_objectWithKeyValues:dict];
        DayModel *beginModel=[[DayModel alloc]initGetHttpData:model.beforeTime];
        DayModel *endModel=[[DayModel alloc]initGetHttpData:model.afterTime];
        
        if (beginModel.day==endModel.day) {
            NSString * todayKey=[NSString stringWithFormat:@"%ld-%ld-%ld",endModel.year,endModel.month,endModel.day];
            NSMutableArray *today=_webTimeData[todayKey];
            if (isArrayEmpty(today)) {
                today=[[NSMutableArray alloc]init];
            }
            [today addObject:@[beginModel,endModel]];
            [_webTimeData setObject:today forKey:todayKey];
        }else{
            /** 今晚23:31结束 */
            DayModel *todayEndModel=[[DayModel alloc]init];
            todayEndModel.year=beginModel.year;
            todayEndModel.month=beginModel.month;
            todayEndModel.day=beginModel.day;
            todayEndModel.hour=23;
            todayEndModel.minute=30;
            NSString * todayKey=[NSString stringWithFormat:@"%ld-%ld-%ld",todayEndModel.year,todayEndModel.month,todayEndModel.day];
            NSMutableArray *today=_webTimeData[todayKey];
            if (isArrayEmpty(today)) {
                today=[[NSMutableArray alloc]init];
            }
            [today addObject:@[beginModel,todayEndModel]];
            [_webTimeData setObject:today forKey:todayKey];
            
            /** 明天0:-1开始 */
            DayModel *tomorrowBeginModel=[[DayModel alloc]init];
            tomorrowBeginModel.year=endModel.year;
            tomorrowBeginModel.month=endModel.month;
            tomorrowBeginModel.day=endModel.day;
            tomorrowBeginModel.hour=0;
            tomorrowBeginModel.minute=0;
            NSString * tomorrowKey=[NSString stringWithFormat:@"%ld-%ld-%ld",endModel.year,endModel.month,endModel.day];
            NSMutableArray *tomorrow=_webTimeData[tomorrowKey];
            if (isArrayEmpty(tomorrow)) {
                tomorrow=[[NSMutableArray alloc]init];
            }
            [tomorrow addObject:@[tomorrowBeginModel,endModel]];
            [_webTimeData setObject:tomorrow forKey:tomorrowKey];
        }
    }
}
-(NSArray *)months {
    if (!_months) {
        _months = @[@"月份",@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    }
    return _months;
}
-(NSArray *)weekDays {
    if (!_weekDays) {
        _weekDays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekDays;
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        [_dataSource addObjectsFromArray:[MLDateManager fetchDate]];
    }
    return _dataSource;
}
-(void)initializeViews {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _nowCompoents =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _titleLabel.text = @"请选择服务日期";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(12);
    }];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn  setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master RemovePopViewWithBlock:nil];
    }];
    
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:7];
    for (NSInteger i = 0; i < 7; i += 1) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:Font_Size(50)];
        label.text = [self.weekDays objectAtIndex:i];
        label.textAlignment =  NSTextAlignmentCenter;
        [self addSubview:label];
        [views addObject:label];
    }
    
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Width - 8*2-5*6)/7 - 3, (Width - 8*2-5*6)/7 + 5);
        flowLayout.minimumInteritemSpacing = 2.5;
        flowLayout.minimumLineSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.collectionView;
    });
    
    _remarkLabel = [[UILabel alloc] init];
    _remarkLabel.text = @"  *最多可预约未来30天";
    _remarkLabel.textColor = [UIColor lightGrayColor];
    _remarkLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _remarkLabel.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    
    [self addSubview:_cancelBtn];
    [self addSubview:self.collectionView];
    [self addSubview:_remarkLabel];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset( - 15);
        make.top.equalTo(self).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(50), Height_Pt(50)));
    }];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelBtn.mas_bottom).with.offset(8);
        make.height.mas_equalTo((Width - 21)/7);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:8 tailSpacing:8];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo( ((Width - 16-30)/7 + 5) * 5 +4*5 + 8*2);
    }];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.and.and.right.and.bottom.equalTo(self);
    }];
}
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.cellIdentifierDic objectForKey:[NSString stringWithFormat:@"%@",indexPath]];
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"selected%@", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellIdentifierDic setObject:identifier forKey:[NSString  stringWithFormat:@"%@",indexPath]];
        
        [_collectionView registerClass:[MLDateCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    MLDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    // 此处可以对Cell做你想做的操作了...
    [cell.contentView makeBorderWidth:0.5 withColor:[UIColor lightGrayColor]];
    MLDateModel *dateModel = self.dataSource[indexPath.item];
    cell.dateNumber = [NSString stringWithFormat:@"%ld",dateModel.day];
    
    if (dateModel.isInThirtyDays) {
        cell.backgroundColor=[UIColor whiteColor];
    }

    if (indexPath.item + 1 >= _nowCompoents.weekday && dateModel.day == 1 ) {
        cell.content = self.months[dateModel.month];
    }
    
    if (indexPath.item + 1 == _nowCompoents.weekday &&_nowCompoents.day<_startTime.day) {
        cell.dateNumber = @"今天";
        cell.content = @"约满";
        cell.numberColor = ThemeColor;
        cell.contentColor = ThemeColor;
        cell.userInteractionEnabled=NO;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDateModel *dateModel = self.dataSource[indexPath.item];
    if (dateModel.isInThirtyDays) {
        OrderSubTime *view=[[OrderSubTime alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(1018), Height_Pt(1186)+20)];
        view.selectTime=dateModel.date;
        view.selectedDate = [NSString stringWithFormat:@"%@(%@)",dateModel.date,self.weekDays[dateModel.week-1]];
        view.subData=[RACSubject subject];
        [view.subData subscribeNext:^(id  _Nullable x) {
            [_subData sendNext:x];
        }];
        /** 开始时间 */
        if (dateModel.year==_startDay.year && dateModel.month==_startDay.month && dateModel.day==_startDay.day) {
            view.startModel=_startDay;
        }
        /** 时间段 */
        view.listArray=[[NSArray alloc]initWithArray:self.webTimeData[[NSString stringWithFormat:@"%@",dateModel.date]]];
        [Master PopAlertView:view];
    }
}
#pragma mark UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
@end
