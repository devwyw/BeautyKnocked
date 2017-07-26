//
//  ConfirmOrderChooseDateView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderChooseDateView.h"
#import "MLDateCollectionViewCell.h"
#import "MLDateManager.h"
#import "MLChooseAppointTimeView.h"



static NSString *const dateCollectionViewCellReuseIdentifier = @"MLDateCollectionViewCell";
@interface ConfirmOrderChooseDateView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MLChooseAppointTimeViewDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *weekDays;

@property (nonatomic, assign) NSInteger todayWeekDay;

@end

@implementation ConfirmOrderChooseDateView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initializeViews];
        
    }
    return self;
}

-(NSArray *)months {
    if (!_months) {
        // add @"月份" atIndex 0, then monthIndex From index 1
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
        _dataSource = [NSMutableArray arrayWithCapacity:35];
        [_dataSource addObjectsFromArray:[MLDateManager fetchDate]];
    }
    return _dataSource;
}

-(void)initializeViews {
    self.type = MMPopupTypeAlert;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *nowCompoents =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    _todayWeekDay = nowCompoents.weekday;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Pt(1018), Height_Pt(1186) + 20 ));
    }];
    
    self.backView = [UIView new];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _titleLabel.text = @"请选择服务日期";
    [self.backView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).with.offset(12);
    }];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn  setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self hide];
    }];
    
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:7];
    for (NSInteger i = 0; i < 7; i += 1) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:Font_Size(50)];
        label.text = [self.weekDays objectAtIndex:i];

        label.textAlignment =  NSTextAlignmentCenter;
        [self.backView addSubview:label];
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
        //_collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerClass:[MLDateCollectionViewCell class] forCellWithReuseIdentifier:dateCollectionViewCellReuseIdentifier];
        self.collectionView;
    });
    
    
    _remarkLabel = [[UILabel alloc] init];
    _remarkLabel.text = @"  *最多可预约未来30天";
    _remarkLabel.textColor = [UIColor lightGrayColor];
    _remarkLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _remarkLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    [self.backView addSubview:_cancelBtn];
    [self.backView addSubview:self.collectionView];
    [self.backView addSubview:_remarkLabel];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView).with.offset( - 15);
        make.top.equalTo(self.backView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(50), Height_Pt(50)));
    }];

    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelBtn.mas_bottom).with.offset(8);
        make.height.mas_equalTo((Width - 21)/7);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:8 tailSpacing:8];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.backView);
        make.height.mas_equalTo( ((Width - 16-30)/7 + 5) * 5 +4*5 + 8*2);
    }];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.and.and.right.and.bottom.equalTo(self.backView);
    }];
    
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 35;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    MLDateModel *dateModel = self.dataSource[indexPath.item];
    if (indexPath.item + 1 == _todayWeekDay) {
        cell.dateNumber = @"今天";
        cell.content = @"约满";
        cell.numberColor = ThemeColor;
        cell.contentColor = ThemeColor;
    }else {
        cell.dateNumber = [NSString stringWithFormat:@"%ld",(long)dateModel.day];
    }
    
    if (indexPath.item + 1 >= _todayWeekDay && dateModel.day == 1 ) {
        cell.content = self.months[dateModel.month];
    }
    
    // border
    if (dateModel.isInThirtyDays) {
        // selected
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = [UIColor colorWithHexString:@"#E1BF6E"];
        cell.selectedBackgroundView = selectedView;
        cell.contentView.layer.borderWidth = 0.5;
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDateModel *dateModel = self.dataSource[indexPath.item];
    NSLog(@"date == %@",dateModel.date);

    if (!dateModel.isInThirtyDays) {
        return;
    }
    
    MLChooseAppointTimeView *chooseAppointTimeView = [[MLChooseAppointTimeView alloc] init];
    chooseAppointTimeView.selectedDate = [NSString stringWithFormat:@"%@(%@)",dateModel.date,self.weekDays[dateModel.week-1]];
    chooseAppointTimeView.delegate = self;
    
    [chooseAppointTimeView show];
}

#pragma mark UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

#pragma mark MLChooseAppointTimeViewDelegate
-(void)shouldHideBackDetailDate:(NSString *)detailDate {
    [self hide];
    [_collectionView reloadData];
}

@end
