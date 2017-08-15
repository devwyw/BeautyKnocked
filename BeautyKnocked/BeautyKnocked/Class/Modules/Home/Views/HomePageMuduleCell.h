//
//  HomePageMuduleCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePageMuduleCellDelegate <NSObject>

-(void)more:(UIButton *)button;
-(void)didSection:(NSInteger)section withSelectedItem:(NSString*)itemID;

@end

@interface HomePageMuduleCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSection:(NSInteger)section;

@property (nonatomic, strong)id <HomePageMuduleCellDelegate> cellDelegate;

@end
