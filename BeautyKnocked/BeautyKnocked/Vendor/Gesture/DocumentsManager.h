//
//  DocumentsManager.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsManager : NSObject

+(instancetype)shareManager;
+(UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
@property (nonatomic,copy) NSString * string;
@end
