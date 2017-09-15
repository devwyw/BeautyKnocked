//
//  ItemDetailController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHeader.h"

@interface ItemDetailController : UIViewController
@property (nonatomic,assign) MLOrderStyle type;
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * alpha;
@end
