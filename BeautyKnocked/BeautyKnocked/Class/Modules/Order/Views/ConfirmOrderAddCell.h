//
//  ConfirmOrderAddCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface ConfirmOrderAddCell : UITableViewCell

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) RACSignal * addMore;
@end
