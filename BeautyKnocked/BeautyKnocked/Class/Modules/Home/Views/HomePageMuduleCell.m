//
//  HomePageMuduleCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageMuduleCell.h"
#import "HomePageItemCollectionViewCell.h"
#import "UIButton+Category.h"

static NSString *const reuseIdentifier = @"HomePageItemCollectionViewCell";

@interface HomePageMuduleCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *moreBtn;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * itemArray;

@end

@implementation HomePageMuduleCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSMutableArray*)itemArray{
    if (!_itemArray) {
        _itemArray=[[NSMutableArray alloc]init];
    }
    return _itemArray;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setSection:(NSString *)section{
    _section=section;
    switch ([section integerValue]) {
        case 5:
            _titleLabel.text = @"每日推荐";
            break;
        case 6:
            _titleLabel.text = @"美丽特惠";
            break;
        case 7:
            _titleLabel.text = @"特价商品";
            break;
        default:
            break;
    }
    [self loadHttpDataWithSection:section];
}
-(void)setupInterface {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self.contentView addSubview:_titleLabel];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_line];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_subPush sendNext:_section];
    }];
    [self.contentView addSubview:_moreBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[HomePageItemCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.contentView addSubview:_collectionView];
}
-(void)setupConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(15));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(25));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).with.offset(- Width_Pt(25));
        make.width.mas_equalTo(Width_Pt(120));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_moreBtn.mas_left).with.offset( - Width_Pt(28));
        make.centerY.equalTo(_moreBtn);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(20));
        make.left.and.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemClassModel * model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.item]];
    HomePageItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model=model;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemClassModel * model=[[ItemClassModel alloc]init];
    model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.item]];
    [_subTypeModel sendNext:@{@"section":_section,@"row":model.id}];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Width - Width_Pt(52)*2 -Width_Pt(42) * 2) / 3, Height_Pt(442));
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Width_Pt(52);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Height_Pt(52);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, Width_Pt(42), 0, Width_Pt(42));
}
-(void)loadHttpDataWithSection:(NSString*)section{
    if (_itemArray.count==0) {
        [Master HttpPostRequestByParams:@{@"type":[NSString stringWithFormat:@"%ld",[section integerValue]-4]} url:mlqqm serviceCode:tjxmlb Success:^(id json) {
            _itemArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
            [_collectionView reloadData];
        } Failure:nil andNavigation:nil];
    }
}
@end
