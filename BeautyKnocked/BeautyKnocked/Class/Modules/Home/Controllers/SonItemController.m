//
//  SonItemController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SonItemController.h"
#import "BeautyItemSortView.h"
#import "ClassItemCollectionCell.h"
#import "ItemDetailController.h"
#import "ProductDetailController.h"
#import <MJRefresh.h>

@interface SonItemController ()<ItemsSortViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BeautyItemSortView *sortView;
@property (nonatomic, strong) NSMutableArray * itemArray;

@end
static NSInteger padding=6;

@implementation SonItemController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.BarAlpha = @"1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titleArray=[[NSArray alloc]initWithObjects:@"每日推荐",@"美丽特惠",@"特价商品",@"上门美甲",@"上门美容",@"上门美发",@"商城",@"疗程套餐", nil];
    self.title=titleArray[self.index];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    [self createViews];
    [self addSubViews];
    [self configureConstraints];
}
-(void)didSelectedButton:(UIButton *)button{
    switch (self.index) {
        case 6:
        {
            [self loadHttpData:self.index withField:5 withLift:1];
        }
            break;
        case 7:
        {
            [self loadHttpData:self.index withField:8 withLift:1];
        }
            break;
            
        default:
        {
            [self loadHttpData:self.index withField:2 withLift:1];
        }
            break;
    }
}
-(void)didSelectWithRow:(NSUInteger)row{
    switch (self.index) {
        case 6:
        {
            if (row==0) {
                [self loadHttpData:self.index];
            }else{
                [self loadHttpData:self.index withField:4 withLift:row-1];
            }
        }
            break;
        case 7:
        {
            if (row==0) {
                [self loadHttpData:self.index];
            }else{
                [self loadHttpData:self.index withField:3 withLift:row-1];
            }
        }
            break;
        default:
        {
            if (row==0) {
                [self loadHttpData:self.index];
            }else{
                [self loadHttpData:self.index withField:1 withLift:row-1];
            }
        }
            break;
    }
}
-(NSMutableArray*)itemArray{
    if (!_itemArray) {
        _itemArray=[[NSMutableArray alloc]init];
    }
    return _itemArray;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassItemCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ClassItemCollectionCell" forIndexPath:indexPath];
    if (_index==7) {
        PackageModel *model=[PackageModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
        cell.Pmodel=model;
    }else{
        ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
        cell.model=model;
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSelected) {
        Weakify(self);
        if (_index==7) {
            PackageModel *model=[PackageModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
            [Master HttpPostRequestByParams:@{@"id":model.id,@"projectId":model.projectId} url:mlqqm serviceCode:tcxq Success:^(id json) {
                [Wself.subModel sendNext:json[@"info"]];
                [Wself.navigationController popViewControllerAnimated:YES];
            } Failure:nil andNavigation:Wself.navigationController];
        }else{
            ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
            [Master HttpPostRequestByParams:@{@"id":model.id} url:mlqqm serviceCode:xmxq Success:^(id json) {
                [Wself.subModel sendNext:json[@"info"]];
                [Wself.navigationController popViewControllerAnimated:YES];
            } Failure:nil andNavigation:Wself.navigationController];
        }
    }else{
        if (_index==6) {
            //产品
            ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
            ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
            productDetailController.alpha=@"0";
            productDetailController.hidesBottomBarWhenPushed = YES;
            productDetailController.productID=model.id;
            [self.navigationController pushViewController:productDetailController animated:YES];
        }else {
            ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
            itemDetailController.alpha=@"0";
            itemDetailController.hidesBottomBarWhenPushed = YES;
            if (_index==7) {
                //套餐
                PackageModel *model=[PackageModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
                itemDetailController.detailID=model.id;
                itemDetailController.projectId=model.projectId;
            }else{
                //项目
                ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:self.itemArray[indexPath.row]];
                itemDetailController.detailID=model.id;
            }
            [self.navigationController pushViewController:itemDetailController animated:YES];
        }
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
    return UIEdgeInsetsMake(0.6, padding, padding, padding);
}
-(void)addSubViews {
    [self.view addSubview:_sortView];
    [self.view addSubview:_collectionView];
}
-(void)createViews {
    _sortView = [[BeautyItemSortView alloc] init];
    _sortView.delegate=self;
    if (_isSelected) {
        _sortView.hidden=YES;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadHttpData:self.index];
    }];
    [_collectionView.mj_header beginRefreshing];
    [_collectionView registerClass:[ClassItemCollectionCell class] forCellWithReuseIdentifier:@"ClassItemCollectionCell"];
}
-(void)configureConstraints {
    if (_isSelected) {
        [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(0);
        }];
    }else{
        [_sortView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(Height_Pt(100));
        }];
    }
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sortView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
#pragma mark ===== 默认排序 =====
-(void)loadHttpData:(NSInteger)index{
    NSString *code=nil;
    switch (index) {
        case 6:
            code=cplb;
            break;
        case 7:
            code=tclb;
            break;
        default:
            code=xmlb;
            break;
    }
    [Master HttpPostRequestByParams:@{@"type":[NSString stringWithFormat:@"%ld",index+1]} url:mlqqm serviceCode:code Success:^(id json) {
        [self.itemArray removeAllObjects];
        for (NSDictionary *dict in json[@"info"]) {
            [self.itemArray addObject:dict];
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
#pragma mark ===== 项目排序 =====
-(void)loadHttpData:(NSInteger)index withField:(NSInteger)field withLift:(NSInteger)lift{
    NSString *code=nil;
    switch (index) {
        case 6:
            code=cplbpx;
            break;
        case 7:
            code=tclbpx;
            break;
        default:
            code=xmlbpx;
            break;
    }
    [Master HttpPostRequestByParams:@{@"type":[NSString stringWithFormat:@"%ld",index+1],
                                      @"field":[NSString stringWithFormat:@"%ld",field],
                                      @"lift":[NSString stringWithFormat:@"%ld",lift],
                                      } url:mlqqm serviceCode:code Success:^(id json) {
                                          [self.itemArray removeAllObjects];
                                          for (NSDictionary *dict in json[@"info"]) {
                                              [self.itemArray addObject:dict];
                                          }
                                          [_collectionView reloadData];
                                      } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
