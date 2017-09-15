//
//  ItemCell.h
//  Technician
//
//  Created by Mac on 2017/8/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
@class RACSubject;

@interface ItemCell : UITableViewCell
@property (nonatomic,strong) ShopCarModel * model;
@property (nonatomic,strong) RACSubject * subCounts;
@property (nonatomic,strong) RACSubject * subEdits;
@property (nonatomic,strong) RACSubject * subCountViews;
@end
