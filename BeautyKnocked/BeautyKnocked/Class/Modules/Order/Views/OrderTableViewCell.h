//
//  OrderTableViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTableViewCellDelegate <NSObject>

-(void)cellPush;

@end

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *beauticianBtn;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic,strong) id<OrderTableViewCellDelegate> cellDelegate;
@end
