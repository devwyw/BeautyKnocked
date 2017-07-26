//
//  ConfirmOrderAddCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmOrderAddCellDelegate <NSObject>

-(void)wantAddMore:(NSString *)currentTitle;

@end

@interface ConfirmOrderAddCell : UITableViewCell

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString * colorStr;

@property (nonatomic, weak) id<ConfirmOrderAddCellDelegate> delegate;

@end
