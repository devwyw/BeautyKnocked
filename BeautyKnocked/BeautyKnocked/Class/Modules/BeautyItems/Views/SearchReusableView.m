//
//  SearchReusableView.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SearchReusableView.h"

@implementation SearchReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, frame.size.width, frame.size.height)];
        [_title setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:_title];
        
        _button=[[UIButton alloc]initWithFrame:CGRectMake(Width-40, 0, 30, 30)];
        [self addSubview:_button];
    }
    return self;
}
@end
