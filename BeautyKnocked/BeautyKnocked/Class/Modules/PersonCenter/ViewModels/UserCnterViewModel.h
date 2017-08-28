//
//  UserCnterViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonCenterHeadView.h"

@interface UserCnterViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PersonCenterHeadView *headView;

-(NSUInteger)numberForRowsInSection:(NSUInteger)section;

-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)configureTableView:(UITableView *)tableView didSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end
