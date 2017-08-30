//
//  HomePageViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageViewModel : NSObject


@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) NSMutableArray * imageArray;

-(NSUInteger)numberOfSectionsInHomePageTableView;

-(NSUInteger)numberOfRowsInHomePageTableViewAtSection:(NSUInteger)section;

-(UITableViewCell *)configureTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath andObject:(id)Cself;

//-(UIView *)configureFooterViewInSection:(NSUInteger)section;

-(CGFloat)configureHeaderHeightAtSection:(NSUInteger )section;

-(CGFloat)configureFooterHeightAtSection:(NSUInteger )section;

-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

-(CGFloat)congigureCellheightAtIndexPath:(NSIndexPath *)indexPath;

@end
