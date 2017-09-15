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
#import "ItemDetailController.h"
#import "ProductDetailController.h"
#import <MJRefresh.h>

@interface ItemListBaseController ()<ItemsSortViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BeautyItemSortView *sortView;
@property (nonatomic, strong) NSMutableArray * itemArray;
@end

static NSInteger padding=6;

@implementation ItemListBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    
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
    switch ([self.model.type integerValue]) {
        case 7:
        {
            [self loadHttpDataWithField:5 withLift:1];
        }
            break;
        case 8:
        {
            [self loadHttpDataWithField:8 withLift:1];
        }
            break;
            
        default:
        {
            [self loadHttpDataWithField:2 withLift:1];
        }
            break;
    }
    
}
-(void)didSelectWithRow:(NSUInteger)row{
    switch ([self.model.type integerValue]) {
        case 7:
        {
            if (row==0) {
                [self loadHttpData];
            }else{
                [self loadHttpDataWithField:4 withLift:row-1];
            }
        }
            break;
        case 8:
        {
            if (row==0) {
                [self loadHttpData];
            }else{
                [self loadHttpDataWithField:3 withLift:row-1];
            }
        }
            break;
        default:
        {
            if (row==0) {
                [self loadHttpData];
            }else{
                [self loadHttpDataWithField:1 withLift:row-1];
            }
        }
            break;
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassItemCollectionCell" forIndexPath:indexPath];
    if ([self.model.type integerValue]==8) {
        cell.Pmodel=[PackageModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
    }else{
        cell.model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.model.type integerValue]==7) {
        ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
        ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
        productDetailController.alpha=@"0";
        productDetailController.hidesBottomBarWhenPushed = YES;
        productDetailController.id=model.id;
        [self.navigationController pushViewController:productDetailController animated:YES];
    }else {
        ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
        itemDetailController.alpha=@"0";
        itemDetailController.hidesBottomBarWhenPushed = YES;
        if ([self.model.type integerValue]==8) {
            PackageModel *model=[PackageModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
            itemDetailController.id=model.id;
            itemDetailController.type=MLPackage;
        }else{
            ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
            itemDetailController.id=model.id;
            itemDetailController.type=MLItem;
        }
        [self.navigationController pushViewController:itemDetailController animated:YES];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Width - padding * 3) / 2, Height_Pt(640));
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return padding;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return padding;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(padding, padding, padding, padding);
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
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[ClassItemCollectionCell class] forCellWithReuseIdentifier:@"ClassItemCollectionCell"];
    _collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHttpData)];
    [_collectionView.mj_header beginRefreshing];
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
#pragma mark ===== 默认排序 =====
-(void)loadHttpData{
    [Master HttpPostRequestByParams:@{@"type":_model.type} url:mlqqm serviceCode:_model.interfacePath Success:^(id json) {
        [_itemArray removeAllObjects];
        _itemArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [_collectionView.mj_header endRefreshing];
        [_collectionView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
#pragma mark ===== 项目排序 =====
-(void)loadHttpDataWithField:(NSInteger)field withLift:(NSInteger)lift{
    NSString *path=[[NSString alloc]init];
    switch ([_model.type integerValue]) {
        case 7:
            path=cplbpx;
            break;
        case 8:
            path=tclbpx;
            break;
        default:
            path=xmlbpx;
            break;
    }
    [Master HttpPostRequestByParams:@{@"type":_model.type,
                                      @"field":[NSString stringWithFormat:@"%ld",field],
                                      @"lift":[NSString stringWithFormat:@"%ld",lift],
                                      } url:mlqqm serviceCode:path Success:^(id json) {
                                          [self.itemArray removeAllObjects];
                                          for (NSDictionary *dict in json[@"info"]) {
                                              [self.itemArray addObject:dict];
                                          }
                                          [_collectionView reloadData];
                                      } Failure:nil andNavigation:self.navigationController];
}
@end
