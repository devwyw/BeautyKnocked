//
//  BeauticianListViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeauticianListViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

+(void)registerTableViewCellWithTableView:(UITableView *)tableView;

-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section;

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath;



@end
