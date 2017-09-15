//
//  IntegralMallViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralMallViewModel : NSObject

@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,copy) NSString * integral;

-(void)ddcs_configureCollectionView:(UICollectionView *)collectionView;

- (NSInteger)ddcs_numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

- (NSInteger)ddcs_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *)ddcs_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

-(CGSize)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGSize)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

-(UIEdgeInsets)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

-(CGFloat)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

-(CGFloat)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (UICollectionReusableView *)ddcs_collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

-(void)ddcs_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat;

@end
