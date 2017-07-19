//
//  BeauticianItemViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeauticianItemViewModel : NSObject

-(NSUInteger)numberOfSectionsInBeauticianItemTableView;

-(NSUInteger)numberOfRowsInBeauticianItemTableViewAtSection:(NSUInteger)section;

-(void)registerCellOfBeauticianItemTableView:(UITableView *)tableView;

-(UITableViewCell *)configureBeauticianItemTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath;

//-(UIView *)configureFooterViewInSection:(NSUInteger)section;

-(CGFloat)configureHeaderHeightAtSection:(NSUInteger )section;

-(CGFloat)configureFooterHeightAtSection:(NSUInteger )section;

-(CGFloat)congigureCellHeightAtIndexPath:(NSIndexPath *)indexPath;

@end
