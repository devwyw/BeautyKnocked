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
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@(0));
            make.height.equalTo(@(35));
            make.right.equalTo(self.message.mas_right).offset(15);
            make.bottom.equalTo(self.message.mas_bottom).offset(10);
        }];
        
        [_message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.contentView).with.offset(15);
            make.height.equalTo(@(15));
        }];
    }
    return self;
}
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.height = 35;
    newFrame.size.width = size.width;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}
@end
