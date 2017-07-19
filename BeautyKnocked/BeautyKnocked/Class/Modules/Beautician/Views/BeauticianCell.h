//
//  BeauticianCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BeauticianCellDelegate <NSObject>

-(void)reserveBeautician;

@end

@interface BeauticianCell : UITableViewCell

@property (nonatomic, weak) id<BeauticianCellDelegate> delegate;

@property (nonatomic, assign) NSUInteger number;

@end
