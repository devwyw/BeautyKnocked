//
//  SearchCollectionCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SearchCollectionCell.h"

@implementation SearchCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [self.layer setCornerRadius:10];
        [self.layer setMasksToBounds:YES];
        
        _message = [[UILabel alloc] init];
        _message.numberOfLines = 1;
        [_message setFont:[UIFont italicSystemFontOfSize:13]];
        _message.textColor=[UIColor colorWithHexString:@"#474747"];
        _message.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_message];
        [_message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
            make.width.greaterThanOrEqualTo(@0.1);
            make.height.greaterThanOrEqualTo(@0.1);
            make.height.equalTo(self.contentView).priorityLow();
        }];
    }
    return self;
}
@end
