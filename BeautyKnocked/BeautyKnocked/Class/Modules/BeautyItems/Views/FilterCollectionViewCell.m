//
//  FilterCollectionViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@interface FilterCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FilterCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wenzikuang"]];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
    }
    return self;
}

-(void)setItemName:(NSString *)itemName {
    _titleLabel.text = itemName;
}

-(void)setItemTextColor:(UIColor *)itemTextColor {
    _titleLabel.textColor = itemTextColor;
}

-(void)setHighLight:(BOOL)highLight {
    _titleLabel.textColor = highLight ? [UIColor orangeColor] : [UIColor blackColor];
}

@end
