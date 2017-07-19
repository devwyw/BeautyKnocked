//
//  SetupViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)configTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)configTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
