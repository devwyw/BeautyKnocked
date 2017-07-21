//
//  ItemListBaseController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemListBaseController.h"
#import "BeautyItemSortView.h"
#import "ClassItemCollectionCell.h"
#import "EntirySortSelectView.h"
#import "PSSortDropMenu.h"
#import "ItemDetailController.h"
#import "ProductDetailController.h"

static NSString *const reuseIdentifier = @"ClassItemCollectionCell";

@interface ItemListBaseController ()<ItemsSortViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BeautyItemSortView *sortView;

@property (nonatomic, strong) PSSortDropMenu *sortMenu;


@end

@implementation ItemListBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViews];
    [self addSubViews];
    [self configureConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didSelectedButton:(UIButton *)button{
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //[self configureCell:cell indexPath:indexPath];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
    itemDetailController.hidesBottomBarWhenPushed = YES;
    
    ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
    productDetailController.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.item % 2 == 0) {
        [self.navigationController pushViewController:itemDetailController animated:YES];
    }else {
        [self.navigationController pushViewController:productDetailController animated:YES];
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Width - 10 * 3) / 2, Height_Pt(640));
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(void)addSubViews {
    [self.view addSubview:_sortView];
    [self.view addSubview:_collectionView];
}

-(void)createViews {

    _sortView = [[BeautyItemSortView alloc] init];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ClassItemCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
}

-(void)configureConstraints {
    
    [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(100));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sortView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-49);
    }];
    
}



@end
