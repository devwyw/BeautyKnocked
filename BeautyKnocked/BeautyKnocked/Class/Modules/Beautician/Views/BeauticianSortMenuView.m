//
//  BeauticianSortMenuView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianSortMenuView.h"
#import "UIButton+Category.h"
#import "PSSortDropMenu.h"
#import "UIImage+Original.h"
#import "MLDateManager.h"
#import "MLDateCollectionViewCell.h"

@interface BeauticianSortMenuView ()<PSSortDropMenuDelegate,UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *sortingBtn;
@property (nonatomic, strong) UIImageView *lineImgView;
@property (nonatomic, strong) UIButton *filterBtn;
@property (nonatomic, strong) PSSortDropMenu *sortMenu;
@property (nonatomic, assign) CGFloat topHeight;

@property (nonatomic, strong) UIView * popView;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, strong) NSArray *weekDays;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger todayWeekDay;
@property (nonatomic,strong) UIButton * donBtn;

@property (nonatomic,strong) NSMutableDictionary * cellIdentifierDic;

@end

@implementation BeauticianSortMenuView
-(NSMutableDictionary*)cellIdentifierDic{
    if (!_cellIdentifierDic) {
        _cellIdentifierDic=[[NSMutableDictionary alloc]init];
    }
    return _cellIdentifierDic;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setupInterface {
    _sortingBtn = [self setupCustomBtnWtihImageName:@"paixu_03" title:@"排序"];
    [_sortingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sortingBtn];
    
    _lineImgView = [[UIImageView alloc] init];
    [_lineImgView setImage:[UIImage imageNamed:@"xian1_03"]];
    [self addSubview:_lineImgView];
    
    _filterBtn = [self setupCustomBtnWtihImageName:@"shaixuan_03" title:@"筛选"];
    [_filterBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterBtn];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    [self initializeViews];
    [_popView setHidden:YES];
}

-(void)buttonClicked:(UIButton *)button {
    button.selected = !button.selected;
    if (button == _sortingBtn) {
        if (button.selected) {
            [self.sortMenu showInView:self.superview];
        }else {
            [self.sortMenu hideView];
        }
    }else{
        if (button.selected) {
            [UIView animateWithDuration:0.2 animations:^{
                [_popView setHidden:NO];
            }];
        }else {
            [UIView animateWithDuration:0.2 animations:^{
                [self.popView setHidden:YES];
            }];
        }
    }
}

-(PSSortDropMenu *)sortMenu {
    if (!_sortMenu) {
        CGRect frame = self.superview.frame;
        _topHeight = 64.0 + Height_Pt(122);
        _sortMenu = [[PSSortDropMenu alloc] initWithFrame:CGRectMake(0, _topHeight, frame.size.width, frame.size.height - _topHeight)];
        _sortMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _sortMenu.dataSource = @[@"默认工号排序",@"评分最高",@"人气最高"];
        _sortMenu.top_heeight = _topHeight;
        _sortMenu.delegate = self;
    }
    return _sortMenu;
}
-(UIView*)popView{
    if (!_popView) {
        _popView=[[UIView alloc]initWithFrame:CGRectMake(0, 100.5, Width, Height-100.5)];
        [_popView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.3]];
    }
    return _popView;
}
#pragma mark PSSortDropMenuDelegate

-(void)haveDismiss {
    _sortingBtn.selected = NO;
}
-(void)didSelectAtRow:(NSUInteger)row{
    
}
-(void)setupConstraints {
    
    [_lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(24));
        make.bottom.equalTo(self).with.offset( - Height_Pt(24));
        make.width.mas_equalTo(Height_Pt(2));
    }];
    
    [_sortingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineImgView);
        make.right.equalTo(_lineImgView.mas_left);
        make.left.equalTo(self);
    }];
    
    [_filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineImgView);
        make.right.equalTo(self);
        make.left.equalTo(_lineImgView.mas_right);
    }];
}

-(UIButton *)setupCustomBtnWtihImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:35/3.f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageOriginalImageName:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleRight imageSize:image.size space:20/3.f];
    return button;
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
        _dataSource = [NSMutableArray arrayWithCapacity:35];
        [_dataSource addObjectsFromArray:[MLDateManager fetchDate]];
    }
    return _dataSource;
}
-(void)initializeViews {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *nowCompoents =[calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    _todayWeekDay = nowCompoents.weekday;
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    [_popView addSubview:self.backView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    titleLabel.text = @"请选择服务日期";
    [self.backView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView).with.offset(12);
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
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.collectionView;
    });
    [self.backView addSubview:self.collectionView];
    
    UIButton *canBtn=[[UIButton alloc]init];
    [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [canBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [canBtn addTarget:self action:@selector(canBtn:) forControlEvents:UIControlEventTouchUpInside];
    canBtn.layer.cornerRadius=5;
    canBtn.layer.masksToBounds=YES;
    [canBtn.layer setBorderWidth:0.5];//设置边界的宽度
    [canBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_backView addSubview:canBtn];
    
    _donBtn=[[UIButton alloc]init];
    [_donBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_donBtn setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    [_donBtn setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
    [_donBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_donBtn addTarget:self action:@selector(donBtn:) forControlEvents:UIControlEventTouchUpInside];
    _donBtn.layer.cornerRadius=5;
    _donBtn.layer.masksToBounds=YES;
    [_backView addSubview:_donBtn];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo((Width - 21)/7);
        make.bottom.equalTo(self.collectionView.mas_top);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:8 tailSpacing:8];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.backView);
        make.height.mas_equalTo( ((Width - 16-30)/7 + 5) * 5 +4*5 + 8*2);
    }];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_popView);
        make.bottom.equalTo(_collectionView.mas_bottom).offset(Height_Pt(158));
    }];
    [canBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).offset(Width_Pt(140));
        make.bottom.equalTo(_backView).offset(-(Height_Pt(158)-Height_Pt(80))/2);
        make.width.mas_equalTo(Width_Pt(240));
        make.height.mas_equalTo(Height_Pt(80));
    }];
    
    [_donBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-Width_Pt(140));
        make.bottom.equalTo(_backView).offset(-(Height_Pt(158)-Height_Pt(80))/2);
        make.width.mas_equalTo(Width_Pt(240));
        make.height.mas_equalTo(Height_Pt(80));
    }];
}
-(void)canBtn:(UIButton*)btn{
    _filterBtn.selected=NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.popView setHidden:YES];
    }];
}
-(void)donBtn:(UIButton*)btn{
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MLDateCollectionViewCell *cell = obj;
        if (cell.selected) {
            _filterBtn.selected=NO;
            [UIView animateWithDuration:0.2 animations:^{
                [self.popView setHidden:YES];
            }];
            *stop = YES;
        }
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
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MLDateModel *dateModel = self.dataSource[indexPath.item];
    NSLog(@"date == %@",dateModel.date);
    
    if (!dateModel.isInThirtyDays) {
        _donBtn.userInteractionEnabled=NO;
        return;
    }
    _donBtn.userInteractionEnabled=YES;
}

#pragma mark UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
@end
