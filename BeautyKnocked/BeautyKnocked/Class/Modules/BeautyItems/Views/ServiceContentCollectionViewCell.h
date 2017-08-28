//
//  ServiceContentCollectionViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface ServiceContentCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign) NSInteger serialNumber;
@property (nonatomic,strong) ImageModel * model;
@end
