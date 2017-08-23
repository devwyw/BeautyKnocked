//
//  OrderTableViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;
@protocol OrderTableViewCellDelegate <NSObject>
-(void)cellPush;
@end

@interface OrderTableViewCell : UITableViewCell
@property (nonatomic,strong) id<OrderTableViewCellDelegate> cellDelegate;
@property (nonatomic,strong) RACSignal * leftPush;
@property (nonatomic,strong) RACSignal * rightPush;
@end
