//
//  ServiceContentCollectionViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceContentCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) NSUInteger serialNumber;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *imgURL;

@end
