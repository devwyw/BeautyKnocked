//
//  IntegralMallController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegralMallController.h"
#import "IntegralMallViewModel.h"

@interface IntegralMallController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) IntegralMallViewModel *integralViewModel;
@property (nonatomic,assign) BOOL isUpData;
@end

@implementation IntegralMallController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isUpData) {
        _integralViewModel.integral=[Acount shareManager].score;
        [self.collectionView reloadData];
    }else{
        _isUpData=YES;
    }
}
-(IntegralMallViewModel *)integralViewModel {
    if (!_integralViewModel) {
        _integralViewModel = [[IntegralMallViewModel alloc] init];
    }
    return _integralViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分商城";
    [self.integralViewModel ddcs_configureCollectionView:self.collectionView];
    self.integralViewModel.navigationController = self.navigationController;
    [self loadHttpData];
}
-(void)loadHttpData{
    Weakify(self);
    Acount *user=[Acount shareManager];
    [Master startStatus];
    /** 第一次请求 */
    [Master WebPostRequestByParams:@{@"id":user.id} url:mlqqm serviceCode:khjf Success:^(id json) {
        Wself.integralViewModel.integral=[NSString stringWithFormat:@"%ld",[json[@"info"] integerValue]];
        user.score=[NSString stringWithFormat:@"%ld",[json[@"info"] integerValue]];
        [user UpdateAcount];
        /** 第二次请求 */
        [Master WebPostRequestByParams:nil url:mlqqm serviceCode:jflb Success:^(id json) {
            [Master stopStatus];
            Wself.integralViewModel.dataArray=[[NSArray alloc]initWithArray:json[@"info"]];
            [Wself.collectionView reloadData];
        } Failure:^(NSError *error) {
            [Master stopStatus];
        } andNavigation:Wself.navigationController];
    } Failure:^(NSError *error) {
        [Master stopStatus];
    } andNavigation:self.navigationController];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.integralViewModel ddcs_numberOfSectionsInCollectionView:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.integralViewModel ddcs_collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.integralViewModel ddcs_collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return [self.integralViewModel ddcs_collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.integralViewModel ddcs_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.integralViewModel ddcs_collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self.integralViewModel ddcs_collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self.integralViewModel ddcs_collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self.integralViewModel ddcs_collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self.integralViewModel ddcs_collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
