//
//  BeauticianItemViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianItemViewModel.h"
#import "BeautyItemsCell.h"

static NSString *const beautyItemsCellReuseIdentifier = @"BeautyItemsCell";
@interface BeauticianItemViewModel ()

@end

@implementation BeauticianItemViewModel

-(void)registerCellOfBeauticianItemTableView:(UITableView *)tableView {
    [tableView registerClass:[BeautyItemsCell class] forCellReuseIdentifier:beautyItemsCellReuseIdentifier];
}

-(NSUInteger)numberOfSectionsInBeauticianItemTableView {
    return 6;
}

-(NSUInteger)numberOfRowsInBeauticianItemTableViewAtSection:(NSUInteger)section {
    return 1;
}

-(UITableViewCell *)configureBeauticianItemTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath {
    BeautyItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:beautyItemsCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)congigureCellHeightAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(320);
}

-(CGFloat)configureHeaderHeightAtSection:(NSUInteger)section {
    return Height_Pt(10);
}

-(CGFloat)configureFooterHeightAtSection:(NSUInteger)section {
    return CGFLOAT_MIN;
}

@end
