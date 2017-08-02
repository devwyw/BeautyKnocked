//
//  ConfirmOrderViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderViewModel.h"
#import "ConfirmOrderAddressCell.h"
#import "ConfirmOrderFillCell.h"
#import "ConfirmOrderAddCell.h"
#import "ConfirmOrderProductCell.h"
#import "ConfirmOrderItemCell.h"
#import "ConfirmOrderRemarksCell.h"
#import "OrderSubDay.h"
#import <SVProgressHUD.h>


static NSString *const addressCellReuseIdentifier = @"ConfirmOrderAddressCell";
static NSString *const confirmOrderFillCellReuseIdentifier = @"ConfirmOrderFillCell";
static NSString *const confirmOrderProductCellReuseIdentifier = @"ConfirmOrderProductCell";
static NSString *const confirmOrderItemCellReuseIdentifier = @"ConfirmOrderItemCell";
static NSString *const confirmOrderAddCellReuseIdentifier = @"ConfirmOrderAddCell";
static NSString *const confirmOrderRemarksCellReuseIdentifier = @"ConfirmOrderRemarksCell";
@interface ConfirmOrderViewModel ()<ConfirmOrderAddCellDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * addArray;

@end

@implementation ConfirmOrderViewModel
-(NSMutableArray*)addArray{
    if (!_addArray) {
        _addArray=[[NSMutableArray alloc]initWithObjects:@"水美人", nil];
    }
    return _addArray;
}
-(void)ddcs_register:(UITableView *)tableview {
    _tableView=tableview;
    [tableview registerClass:[ConfirmOrderAddressCell class] forCellReuseIdentifier:addressCellReuseIdentifier];
    
    [tableview registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:confirmOrderFillCellReuseIdentifier];
    
    [tableview registerClass:[ConfirmOrderProductCell class] forCellReuseIdentifier:confirmOrderProductCellReuseIdentifier];
    
     [tableview registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:confirmOrderItemCellReuseIdentifier];
    
    [tableview registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:confirmOrderAddCellReuseIdentifier];
    
    [tableview registerClass:[ConfirmOrderRemarksCell class] forCellReuseIdentifier:confirmOrderRemarksCellReuseIdentifier];
}

-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.addArray.count+3;
    }
    return [self.titles[section] count];
    
}
-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ConfirmOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row < 2) {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderFillCellReuseIdentifier forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.title = self.titles[indexPath.section][indexPath.row];
            return cell;
        }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderAddCellReuseIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            cell.title = self.orderStyle == MLItem ? @"添加项目":@"添加产品";
            return cell;
        }
        if (self.orderStyle == MLProduct) {
            ConfirmOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderProductCellReuseIdentifier forIndexPath:indexPath];
            
            cell.itemName = _addArray[indexPath.row-2];
            cell.itemImage = [UIImage imageNamed:@"touxiang_03"];
            cell.price = @"¥ 500";
            return cell;
        }
        if (self.orderStyle == MLItem) {
            ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:confirmOrderItemCellReuseIdentifier forIndexPath:indexPath];
            
            cell.itemName = _addArray[indexPath.row-2];
            cell.itemImage = [UIImage imageNamed:@"touxiang_03"];
            cell.price =88;
            cell.blcakprice=128;
            cell.serviceLength = [NSString stringWithFormat:@"服务时90长分钟"];
            return cell;
        }
        
    }else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderFillCellReuseIdentifier forIndexPath:indexPath];
            cell.title = self.titles[indexPath.section][indexPath.row];
            cell.content=@"暂无优惠券";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        ConfirmOrderRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderRemarksCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }
    return nil;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}

-(void)ddcs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == [NSIndexPath indexPathForRow:1 inSection:1]) {
        OrderSubDay *view=[[OrderSubDay alloc]initWithFrame:CGRectMake(0, 0,Width_Pt(1018), Height_Pt(1186) + 20)];
        [view makeCornerRadius:5];
        [LEEAlert alert].config
        .LeeCustomView(view)
        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderColor([UIColor clearColor])
        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
            return Width_Pt(1018);
        })
        .LeeShow();
    }
}

-(NSArray *)titles {
    if (!_titles) {
        _titles = @[@[@""],@[@"选择技师",@"预约时间:",@"配送方式:"],@[@"选择优惠券:",@"备注:"]];
    }
    return _titles;
}

#pragma mark ConfirmOrderAddCellDelegate
-(void)wantAddMore:(NSString *)currentTitle {
    if (_addArray.count>=4) {
        [SVProgressHUD showInfoWithStatus:@"您已超过四个项目，考虑时间因素不可继续添加项目"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1.85];
    }else{
        [_addArray addObject:currentTitle];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count+1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+2 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

@end
