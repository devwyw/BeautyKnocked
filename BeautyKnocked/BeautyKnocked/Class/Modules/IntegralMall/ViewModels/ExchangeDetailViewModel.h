//
//  ExchangeDetailViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeDetailViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

-(NSInteger)ddcs_numnumberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

-(void)ddcs_registerClassForTableView:(UITableView *)tablView;

-(void)exchangeClicked:(UIButton *)button;

@end
