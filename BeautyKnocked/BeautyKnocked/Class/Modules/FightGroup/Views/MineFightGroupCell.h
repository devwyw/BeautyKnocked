//
//  MineFightGroupCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineFightGroupCellDelegate <NSObject>

-(void)didClickedAtIndex:(NSUInteger)index;

@end

@interface MineFightGroupCell : UITableViewCell

@property (nonatomic, weak) id<MineFightGroupCellDelegate> delegate;

@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *people;
@property (nonatomic, copy) NSString *hourglass;
@property (nonatomic, copy) NSAttributedString *price;
@property (nonatomic, copy) NSString *title0;
@property (nonatomic, copy) NSString *title1;

@end
