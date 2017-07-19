//
//  ProductDetailViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView;

-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;

-(void)configRegisterTableView:(UITableView *)tableView;

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//-(void)configTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//
//-(CGFloat)configTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
