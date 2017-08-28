//
//  ConfirmOrderRemarksCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface ConfirmOrderRemarksCell : UITableViewCell
@property (nonatomic,strong) RACSubject * subText;
@property (nonatomic,copy) NSString * text;
@end
