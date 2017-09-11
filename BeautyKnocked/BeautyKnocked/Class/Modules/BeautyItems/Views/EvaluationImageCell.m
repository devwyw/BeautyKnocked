//
//  EvaluationImageCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/3.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationImageCell.h"

@interface EvaluationImageCell ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation EvaluationImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode=UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds=YES;
        [self.contentView addSubview:_imgView];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName {
    _imgView.image=[UIImage imageNamed:imageName];
}

@end
