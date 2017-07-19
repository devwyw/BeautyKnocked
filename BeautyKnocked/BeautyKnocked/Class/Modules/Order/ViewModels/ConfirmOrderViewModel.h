//
//  ConfirmOrderViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHeader.h"

@interface ConfirmOrderViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) MLOrderStyle orderStyle;

-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
-(void)ddcs_register:(UITableView *)tableview;

-(void)ddcs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
