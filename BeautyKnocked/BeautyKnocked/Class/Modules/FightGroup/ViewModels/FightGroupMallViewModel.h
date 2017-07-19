//
//  FightGroupMallViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FightGroupMallViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
-(void)ddcs_registerClass:(UITableView *)tableView;
-(UIView *)ddcs_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
@end
