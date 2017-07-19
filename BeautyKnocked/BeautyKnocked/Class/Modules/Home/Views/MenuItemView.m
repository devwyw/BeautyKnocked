//
//  MenuItemView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MenuItemView.h"
#import "MenuItemCollectionCell.h"

static NSString *const reuseIdentifier = @"MenuItemCollectionCell";

@interface MenuItemView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MenuItemView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createCollectionView];
        
        [self makeConstraints];
        
    }
    return self;
}

-(void)createCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[MenuItemCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:_collectionView];
}

-(void)makeConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(menuItemViewTitleSelect:andMtag:)]) {
        [self.delegate menuItemViewTitleSelect:indexPath.item andMtag:_Mtag];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return _interitemSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return _cellEdgeInsets;
}

-(void)setDataArray:(NSArray *)dataArray {
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:dataArray];
}


-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)configureCell:(MenuItemCollectionCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    cell.imgeViewSize =  _imgeViewSize;
    cell.topDistance = _topDistance;
    cell.middleDistance = _middleDistance;
    cell.bottomDistance = _bottomDistance;
    
    cell.titleFont = _titleFont;
    
    cell.imageName = [[self.dataSource objectAtIndex:indexPath.item] objectForKey:@"image"];
    cell.menuItemName = [[self.dataSource objectAtIndex:indexPath.item] objectForKey:@"title"];
    
}

@end
