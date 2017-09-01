//
//  OrderSubTime.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderSubTime.h"
#import "MLDateCollectionViewCell.h"
#import "MLDateManager.h"
#import "OrderSubDay.h"

@interface OrderSubTime ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView * backview;
@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIButton * confirmBtn;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableDictionary * cellIdentifierDic;
@property (nonatomic, copy) NSString * selectsTime;

@end

@implementation OrderSubTime

-(NSMutableDictionary*)cellIdentifierDic{
    if (!_cellIdentifierDic) {
        _cellIdentifierDic=[[NSMutableDictionary alloc]init];
    }
    return _cellIdentifierDic;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
-(void)setSelectedDate:(NSString *)selectedDate {
    _selectedDate = selectedDate;
    _dateLabel.text = selectedDate;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        [_dataSource addObjectsFromArray:[MLDateManager fetchOneDayTime]];
    }
    return _dataSource;
}
-(void)initializeViews {
    _backview=[[UIView alloc]init];
    _backview.backgroundColor=[UIColor whiteColor];
    [_backview makeCornerRadius:5];
    [self addSubview:_backview];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        OrderSubDay *view=[OrderSubDay shareManager];
        [Master PopAlertView:view];
    }];
    [self addSubview:_backBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"请选择服务日期";
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"2048-05-49(周四)";
    _dateLabel.textColor = [UIColor darkGrayColor];
    _dateLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [self addSubview:_dateLabel];
    
    // cancel
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master RemovePopViewWithBlock:nil];
    }];
    [self addSubview:_cancelBtn];
    
    
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Width_Pt(1018) - 5*5)/4, Height_Pt(130));
        flowLayout.minimumInteritemSpacing = 0.25;
        flowLayout.minimumLineSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.collectionView;
    });
    [self addSubview:_collectionView];
    
    /** 确定 */
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_confirmBtn makeCornerRadius:5];
    [_confirmBtn setBackgroundColor:ThemeColor];
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //确定
        [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MLDateCollectionViewCell *cell = obj;
            if (cell.selected) {
                [Master RemovePopViewWithBlock:^{
                    [_subData sendNext:[NSString stringWithFormat:@"%@ %@:00",_selectTime,_selectsTime]];
                }];
                
                *stop = YES;
            }
        }];
    }];
    [self addSubview:_confirmBtn];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.bottom.equalTo(_collectionView.mas_top).offset(0);
        make.width.mas_equalTo(40);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backBtn);
        make.right.equalTo(self).with.offset( - 15);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(50), Height_Pt(50)));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(12);
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(260);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, Height_Pt(110)));
    }];
    
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_confirmBtn.mas_bottom).offset(10);
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
    
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor colorWithHexString:@"#E1BF6E"];
    cell.selectedBackgroundView = selectedView;
    [cell.contentView makeBorderWidth:0.5 withColor:[UIColor lightGrayColor]];
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    cell.dateNumber = self.dataSource[indexPath.item];

    NSArray *nowTime=[[NSArray alloc]init];
    nowTime=[self.dataSource[indexPath.item] componentsSeparatedByString:@":"];
    
    if ([nowTime.firstObject integerValue]<_startModel.hour) {
        cell.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
        cell.content=@"约满";
        cell.userInteractionEnabled=NO;
    }else{
        if ([nowTime.firstObject integerValue]==_startModel.hour && [nowTime.lastObject integerValue]<_startModel.minute) {
            cell.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
            cell.content=@"约满";
            cell.userInteractionEnabled=NO;
        }
    }
    for (NSArray *timeArray in _listArray) {
        DayModel *beginModel=timeArray.firstObject;
        DayModel *endModel=timeArray.lastObject;
        if ([nowTime.firstObject integerValue]>beginModel.hour && [nowTime.firstObject integerValue]<endModel.hour) {//大范围
            cell.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
            cell.content=@"约满";
            cell.userInteractionEnabled=NO;
        }else{//局部
            if ([nowTime.firstObject integerValue]==beginModel.hour && [nowTime.lastObject integerValue]>=beginModel.minute) {
                cell.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
                cell.content=@"约满";
                cell.userInteractionEnabled=NO;
            }else if ([nowTime.firstObject integerValue]==endModel.hour && [nowTime.lastObject integerValue]<=endModel.minute){
                cell.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
                cell.content=@"约满";
                cell.userInteractionEnabled=NO;
            }
        }
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectsTime=self.dataSource[indexPath.item];
}
#pragma mark UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(12, 5, 10, 5);
}
@end
