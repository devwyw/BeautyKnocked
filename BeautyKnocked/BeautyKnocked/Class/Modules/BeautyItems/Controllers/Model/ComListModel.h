//
//  ComListModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComListModel : NSObject
/** 回复列表 */
@property (nonatomic,copy) NSString * commentId;
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * sort;
@end
