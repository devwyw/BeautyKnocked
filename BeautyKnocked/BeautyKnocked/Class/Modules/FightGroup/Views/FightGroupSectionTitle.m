//
//  FightGroupSectionTitle.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupSectionTitle.h"

@interface FightGroupSectionTitle ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation FightGroupSectionTitle

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
        [self addSubview:_textLabel];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).with.offset(Width_Pt(35));
        }];
        
    }
    return self;
}
-(void)setTitle:(NSString *)title {
    _textLabel.text = title;
}
@end
