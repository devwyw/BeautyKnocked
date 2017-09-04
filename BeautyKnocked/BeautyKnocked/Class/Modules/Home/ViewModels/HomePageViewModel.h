//
//  HomePageViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeauticianModel.h"

@interface HomePageViewModel : NSObject

@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSMutableArray * itemArray;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) BeauticianModel * beauticianmodel;

-(void)registerClassWith:(UITableView*)tableview;
-(NSUInteger)numberOfSectionsInHomePageTableView;
-(NSUInteger)numberOfRowsInHomePageTableViewAtSection:(NSUInteger)section;
-(UITableViewCell *)configureTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath andObject:(id)Cself;
-(CGFloat)configureHeaderHeightAtSection:(NSUInteger )section;
-(CGFloat)configureFooterHeightAtSection:(NSUInteger )section;
-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
-(void)tableviewWithDidSelected:(NSIndexPath*)indexPath;
-(CGFloat)congigureCellheightAtIndexPath:(NSIndexPath *)indexPath;
@end
