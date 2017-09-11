//
//  IntegralMallViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegralMallViewModel.h"
#import "EvaluationImageCell.h"
#import "TitleCollectionViewCell.h"
#import "ExchangeProductCollectionViewCell.h"
#import "IntegralSectionHeaderView.h"
#import "ExchangeDetailController.h"
#import "ExchangeRecordingController.h"
#import "IntegraListModel.h"

static NSString *const titleCollectionViewCellReuseIdentifier = @"TitleCollectionViewCell";
static NSString *const exchangeProductCollectionViewCellReuseIdentifier = @"ExchangeProductCollectionViewCell";
static NSString *const evaluationImageCellReuseIdentifier = @"EvaluationImageCell";
static NSString *const integralSectionHeaderViewReuseIdentifier = @"IntegralSectionHeaderView";
@interface IntegralMallViewModel ()

@end

@implementation IntegralMallViewModel
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSArray alloc]init];
    }
    return _dataArray;
}
-(void)ddcs_configureCollectionView:(UICollectionView *)collectionView {
    collectionView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    // register 
    [collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:titleCollectionViewCellReuseIdentifier];
    [collectionView registerClass:[ExchangeProductCollectionViewCell class] forCellWithReuseIdentifier:exchangeProductCollectionViewCellReuseIdentifier];
    [collectionView registerClass:[EvaluationImageCell class] forCellWithReuseIdentifier:evaluationImageCellReuseIdentifier];
    
    [collectionView registerClass:[IntegralSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:integralSectionHeaderViewReuseIdentifier];
}

-(NSInteger)ddcs_numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
-(NSInteger)ddcs_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count+1;
    }
}

-(UICollectionViewCell *)ddcs_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EvaluationImageCell *imageSectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:evaluationImageCellReuseIdentifier forIndexPath:indexPath];
        imageSectionCell.imageName = @"jifenbanner";
        return imageSectionCell;
    }else{
        if (indexPath.item == 0) {
            TitleCollectionViewCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:titleCollectionViewCellReuseIdentifier forIndexPath:indexPath];
            return titleCell;
        }else{
            ExchangeProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:exchangeProductCollectionViewCellReuseIdentifier forIndexPath:indexPath];
            cell.model=[IntegraListModel mj_objectWithKeyValues:self.dataArray[indexPath.item-1]];
            cell.isType = indexPath.item %2==1;
            return cell;
        }
    }
}

- (UICollectionReusableView *)ddcs_collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        Weakify(self);
        IntegralSectionHeaderView *sectionHeader1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:integralSectionHeaderViewReuseIdentifier forIndexPath:indexPath];
        sectionHeader1.integralBalance = [NSString stringWithFormat:@"%ld",_integral];
        [[sectionHeader1.recordingSignal takeUntil:sectionHeader1.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
            ExchangeRecordingController *recordingController = [[ExchangeRecordingController alloc] init];
            [Wself.navigationController pushViewController:recordingController animated:YES];
        }];
        
        return sectionHeader1;
    }
    return nil;
}

-(void)ddcs_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat {
    if (indexPat.section==1) {
        ExchangeDetailController *detailController = [[ExchangeDetailController alloc] init];
        IntegraListModel *model=[IntegraListModel mj_objectWithKeyValues:self.dataArray[indexPat.item-1]];
        detailController.aid=model.id;
        detailController.isType=indexPat.item %2==1;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

-(CGSize)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    NSUInteger item = indexPath.item;
    if (section == 0) {
        return CGSizeMake(Width, Height_Pt(452));
    }else if (section == 1) {
        if (item == 0) {
            return CGSizeMake(Width, Height_Pt(100));
        }
        return CGSizeMake(Width / 2 - 0.25, Height_Pt(458));
    }
    
    return CGSizeZero;
}

- (CGSize)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(Width, Height_Pt(134));
    }
    return CGSizeZero;
}

-(UIEdgeInsets)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 0, 0, 0);
}

-(CGFloat)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 0.5;
}

-(CGFloat)ddcs_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 0.5;
}

@end
