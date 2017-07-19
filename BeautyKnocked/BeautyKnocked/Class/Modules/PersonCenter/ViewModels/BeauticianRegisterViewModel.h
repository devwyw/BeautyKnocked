//
//  BeauticianRegisterViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeauticianRegisterViewModel : NSObject

-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)configTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)configureRegisterTableView:(UITableView *)tableView;

@end
