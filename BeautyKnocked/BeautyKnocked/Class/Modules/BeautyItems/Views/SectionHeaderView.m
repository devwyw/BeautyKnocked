//
//  SectionHeaderView.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/23.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = [[UILabel alloc]init];
        [_title setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:_title];
        
        _button=[[UIButton alloc]init];
        [self addSubview:_button];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.bottom.equalTo(self).offset(0);
        }];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.right.equalTo(self.mas_right).offset(-20);
            make.width.mas_equalTo(30);
        }];
    }
    return self;
}
@end
