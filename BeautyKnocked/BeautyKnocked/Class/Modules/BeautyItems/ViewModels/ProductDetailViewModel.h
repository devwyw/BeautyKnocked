//
//  ProductDetailViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@interface ProductDetailViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic,strong) ProductModel * model;
@property (nonatomic,strong) NSArray * listArray;

-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView;
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;
-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
