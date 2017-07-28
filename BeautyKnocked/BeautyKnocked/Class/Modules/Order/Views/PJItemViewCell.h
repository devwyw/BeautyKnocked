//
//  PJItemViewCell.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJItemViewCell : UITableViewCell

@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,copy) NSString * titleStr;
@property (nonatomic,strong) UIButton * addImage;
@property (nonatomic,strong) UITextView * textview;

@end
