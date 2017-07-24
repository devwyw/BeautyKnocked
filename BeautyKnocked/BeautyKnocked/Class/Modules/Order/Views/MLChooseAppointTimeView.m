//
//  MLChooseAppointTimeView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MLChooseAppointTimeView.h"
#import "MLDateCollectionViewCell.h"
#import "MLDateManager.h"

static NSString *const dateCollectionViewCellReuseIdentifier = @"MLDateCollectionViewCell";
@interface MLChooseAppointTimeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MLChooseAppointTimeView

-(instancetype)init {
    self = [super init];
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
        _dataSource = [NSMutableArray arrayWithCapacity:48];
        [_dataSource addObjectsFromArray:[MLDateManager fetchOneDayTime]];
    }
    return _dataSource;
}

-(void)initializeViews {
    
    self.type = MMPopupTypeAlert;
    
    MMPopupCompletionBlock completionBlock = ^(MMPopupView *popupView, BOOL finished){
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(shouldHideBackDetailDate:)]) {
                [self.delegate shouldHideBackDetailDate:nil];
            }
        }
    };

    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Pt(1018), Height_Pt(1186) + 20 ));
    }];
    
    self.backView = [UIView new];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // hide self
        [self hide];
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"请选择服务日期";
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"2048-05-49(周四)";
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    
    // cancel
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // hide time and date
        [self hideWithBlock:completionBlock];
        
    }];

    
    self.collectionView = ({
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((Width_Pt(1018) - 5*5)/4, Height_Pt(130));
        flowLayout.minimumInteritemSpacing = 0.25;
        flowLayout.minimumLineSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [_collectionView registerClass:[MLDateCollectionViewCell class] forCellWithReuseIdentifier:dateCollectionViewCellReuseIdentifier];
        self.collectionView;
    });
    
    // confirm
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_confirmBtn setBackgroundColor:ThemeColor];
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // hide time and date
        [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MLDateCollectionViewCell *cell = obj;
            if (cell.selected) {
                [self hideWithBlock:completionBlock];
                *stop = YES;
            }
        }];

    }];
    
    [self.backView addSubview:_backBtn];
    [self.backView addSubview:_titleLabel];
    [self.backView addSubview:_dateLabel];
    [self.backView addSubview:_cancelBtn];
    [self.backView addSubview:_collectionView];
    [self.backView addSubview:_confirmBtn];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(0);
        make.left.equalTo(self.backView).with.offset(0);
        make.bottom.equalTo(_collectionView.mas_top).offset(0);
        make.width.mas_equalTo(40);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backBtn);
        make.right.equalTo(self.backView).with.offset( - 15);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(50), Height_Pt(50)));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).with.offset(12);
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(Height_Pt(40));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).with.offset(10);
        make.left.and.right.equalTo(self.backView);
        make.height.mas_equalTo(260);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(8);
        make.bottom.equalTo(self.backView).with.offset( - 8);
        make.width.mas_equalTo(120);
    }];

}
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    // border
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor colorWithHexString:@"#E1BF6E"];
    cell.selectedBackgroundView = selectedView;
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    cell.dateNumber = self.dataSource[indexPath.item];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(12, 5, 10, 5);
}

@end
