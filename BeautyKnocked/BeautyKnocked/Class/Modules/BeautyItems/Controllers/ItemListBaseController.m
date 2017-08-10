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
#import "ItemClassModel.h"

static NSString *const reuseIdentifier = @"ClassItemCollectionCell";

@interface ItemListBaseController ()<ItemsSortViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BeautyItemSortView *sortView;
@property (nonatomic, strong) PSSortDropMenu *sortMenu;

@property (nonatomic, strong) NSMutableArray * itemArray;
@end

@implementation ItemListBaseController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
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
-(NSMutableArray*)itemArray{
    if (!_itemArray) {
        _itemArray=[[NSMutableArray alloc]init];
    }
    return _itemArray;
}
-(void)didSelectedButton:(UIButton *)button{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemClassModel *model=[[ItemClassModel alloc]init];
    model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
    ClassItemCollectionCell *cell = [ClassItemCollectionCell itemWithCollectionView:collectionView WithIndexPath:indexPath WithModel:model];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==5) {
        ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
        productDetailController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productDetailController animated:YES];
    }else {
        ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
        itemDetailController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:itemDetailController animated:YES];
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
    _sortView.delegate=self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ClassItemCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self loadHttpData:_index];
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
-(void)loadHttpData:(NSInteger)index{
    [Master HttpPostRequestByParams:@{@"type":[NSString stringWithFormat:@"%ld",index]} url:mlqqm serviceCode:xmlb Success:^(id json) {
        if ([Master getSuccess:json]) {
            for (NSDictionary *dict in json[@"info"]) {
                [self.itemArray addObject:dict];
            }
            [_collectionView reloadData];
        }
    } Failure:nil];
}


@end
