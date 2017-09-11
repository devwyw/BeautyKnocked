//
//  IntegralMallController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegralMallController.h"
#import "IntegralMallViewModel.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface IntegralMallController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) IntegralMallViewModel *integralViewModel;
@end

@implementation IntegralMallController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadHttpData{
    Weakify(self);
    Acount *user=[Acount shareManager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    {/** 菊花 */
        [SVProgressHUD show];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setMinimumDismissTimeInterval:3];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    /** 第一次请求 */
    [manager POST:[NSString stringWithFormat:@"%@%@",mlqqm,khjf] parameters:@{@"id":user.id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        Wself.integralViewModel.integral=[resultDic[@"info"] integerValue];
        user.score=[NSString stringWithFormat:@"%ld",[resultDic[@"info"] integerValue]];
        [user UpdateAcount];
        /** 第二次请求 */
        [manager POST:[NSString stringWithFormat:@"%@%@",mlqqm,jflb] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            [SVProgressHUD dismiss];
            NSData *data = responseObject;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            Wself.integralViewModel.dataArray=[[NSArray alloc]initWithArray:resultDic[@"info"]];
            [Wself.collectionView reloadData];
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            [SVProgressHUD dismiss];
            NSLog(@"网络请求错误: %@",error);
            [Master showSVProgressHUD:[NSString stringWithFormat:@"网络连接错误,错误代码%ld",error.code] withType:ShowSVProgressTypeError withShowBlock:nil];
        }];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [SVProgressHUD dismiss];
        NSLog(@"网络请求错误: %@",error);
        [Master showSVProgressHUD:[NSString stringWithFormat:@"网络连接错误,错误代码%ld",error.code] withType:ShowSVProgressTypeError withShowBlock:nil];
    }];
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
@end
