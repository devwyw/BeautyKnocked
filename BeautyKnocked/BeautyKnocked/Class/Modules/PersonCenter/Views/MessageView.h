//
//  MessageView.h
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface MessageView : UIView
@property (nonatomic,strong) RACSubject * subMessage;
@end
