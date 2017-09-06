//
//  ExchangeDetailViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeDetailViewModel.h"
#import "CouponDescriptionCell.h"
#import "ExchangeDetailCouponImage.h"
#import "ExchangeSuccessController.h"

static NSString *const couponDescriptionCellIdentifier = @"CouponDescriptionCell";
static NSString *const cellReuseIdentifier = @"UITableViewCell";

@interface ExchangeDetailViewModel ()
@property (nonatomic, strong) ExchangeDetailCouponImage *couponImage;
@end

@implementation ExchangeDetailViewModel

-(void)ddcs_registerClassForTableView:(UITableView *)tablView {
    [tablView registerClass:[CouponDescriptionCell class] forCellReuseIdentifier:couponDescriptionCellIdentifier];
}

-(NSInteger)ddcs_numnumberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 4;
    }
    return 1;
}

-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CouponDescriptionCell *descriptionCell = [tableView dequeueReusableCellWithIdentifier:couponDescriptionCellIdentifier forIndexPath:indexPath];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if (section == 0) {
        [cell.contentView addSubview:self.couponImage];
        [self.couponImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(Height_Pt(50), Width_Pt(254), Height_Pt(50), Width_Pt(254)));
        }];
        
        self.couponImage.productName = @" 紫根护胸膏";
        self.couponImage.offset = @"60";
        [self.couponImage setImage:[UIImage imageNamed:@"youhuiquan1"]];
        return cell;
    }else if (section == 1) {
        
        
        descriptionCell.title = @"60元产品优惠券";
        descriptionCell.descrText = @"1000 积分 ¥60.0";
        
        return descriptionCell;
    }else if (section == 2) {
        if (row == 0) {
            cell.textLabel.text = @"▸详情说明";
            cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            return cell;
        }else {
            
            descriptionCell.title = @"优惠券简介";
            descriptionCell.descrText = @"fsdkjlfsdiofio\nisdifkjsdklfkl\ndsfijojklsdfkjl";
            return descriptionCell;
        }
    }
    
    
    return nil;
}

-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

-(ExchangeDetailCouponImage *)couponImage {
    if (!_couponImage) {
        _couponImage = [[ExchangeDetailCouponImage alloc] init];
    }
    return _couponImage;
}

-(void)exchangeClicked:(UIButton *)button {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定使用1000积分兑换?" message:nil preferredStyle:UIAlertControllerStyleAlert];
   UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
   }];
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ExchangeSuccessController *successController = [[ExchangeSuccessController alloc] init];
        [self.navigationController pushViewController:successController animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okayAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

@end
