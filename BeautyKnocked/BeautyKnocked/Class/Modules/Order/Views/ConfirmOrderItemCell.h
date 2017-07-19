//
//  ConfirmOrderItemCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderItemCell : UITableViewCell

@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serviceLength;
@property (nonatomic, copy) NSAttributedString *price;

@end
