//
//  PSRightFilterView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PSRightFilterView.h"
#import "FilterCollectionViewCell.h"
#import "FilterCollectionReusableHeaderView.h"

static NSString *const reuseIdentifier = @"FilterCollectionViewCell";
static NSString *const reuseIdentifierHeader = @"FilterCollectionReusableHeaderView";
@interface PSRightFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *emptyButton;

@property (nonatomic, strong) UIButton *determineButton;

@end

@implementation PSRightFilterView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self addConstraints];
    }
    return self;
}

-(void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.itemName = self.dataSource[indexPath.section][indexPath.item];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionReusableHeaderView *headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
    NSArray *titles = @[@"热卖爆款",@"美肤秘籍"];
    headerReusableView.title = [titles objectAtIndex:indexPath.section];
    return headerReusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.highLight = !cell.highLight;
    NSLog(@"highLight == %d",cell.highLight);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = Width_Pt(250);
    CGFloat height = Height_Pt(80);
    
    return CGSizeMake(width, height);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Width_Pt(801), Height_Pt(60));
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Width_Pt(99);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Height_Pt(32);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(Height_Pt(42), Width_Pt(105), Height_Pt(50), Width_Pt(95));
}
-(void)createViews {
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"quxiaojian"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"筛选";
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [self addSubview:_titleLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[FilterCollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
    [self addSubview:_collectionView];
    
    _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _emptyButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    [_emptyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_emptyButton setTitle:@"清空" forState:UIControlStateNormal];
    [_emptyButton setBackgroundImage:[UIImage imageNamed:@"qingkongkuang"] forState:UIControlStateNormal];
    [self addSubview:_emptyButton];
    
    _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _determineButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [_determineButton setBackgroundImage:[UIImage imageNamed:@"quedingkuang"] forState:UIControlStateNormal];
    [_determineButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_determineButton];
    
}

-(void)cancelButtonClicked:(UIButton *)button {
    if (self.filterBlock) {
        self.filterBlock();
    }

}

-(void)addConstraints {
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20.f);
        make.left.equalTo(self).with.offset(Width_Pt(30));
        make.width.mas_equalTo(Width_Pt(45));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cancelButton);
        make.centerX.equalTo(self);
        
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(65));
        make.left.and.right.equalTo(self);
    }];
    
    [@[_emptyButton,_determineButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(49.f);
    }];
    
    [_emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
    }];
    
    [_determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_emptyButton.mas_right);
        make.right.equalTo(self);
        make.width.equalTo(_emptyButton.mas_width);
    }];
    
}

@end
