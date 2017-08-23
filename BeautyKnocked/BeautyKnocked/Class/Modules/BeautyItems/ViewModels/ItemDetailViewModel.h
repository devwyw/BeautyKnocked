//
//  ItemDetailViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailModel;
@class PackageInfoModel;

@interface ItemDetailViewModel : NSObject

@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) NSArray * listArray;
@property (nonatomic,strong) DetailModel * model;
@property (nonatomic,strong) PackageInfoModel * Pmodel;

-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView;
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;
-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
