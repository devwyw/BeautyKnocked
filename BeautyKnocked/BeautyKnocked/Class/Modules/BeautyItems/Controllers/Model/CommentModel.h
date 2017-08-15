//
//  CommentModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/** 评论列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * score;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * imagesPaht;
@property (nonatomic,copy) NSString * beauticianName;
@property (nonatomic,strong) NSArray * replys;
@end
