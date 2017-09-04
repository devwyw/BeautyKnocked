//
//  HomePageMuduleCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface HomePageMuduleCell : UITableViewCell
@property (nonatomic,copy) NSString * section;
@property (nonatomic,strong) RACSubject * subPush;
@property (nonatomic,strong) RACSubject * subTypeModel;
@end
