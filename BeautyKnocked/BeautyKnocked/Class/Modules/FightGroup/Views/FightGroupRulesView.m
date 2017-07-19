//
//  FightGroupRulesView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupRulesView.h"
#import "UIButton+Category.h"

@interface FightGroupRulesView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *explainButton;
@property (nonatomic, strong) UILabel *descriLabel;
@end
@implementation FightGroupRulesView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    _titleLabel =[[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _explainButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_explainButton setTitle:@"规则说明" forState:UIControlStateNormal];
    _explainButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    UIImage *moreImage = [UIImage imageNamed:@"gengduo-lan"];
    [_explainButton setImage:moreImage forState:UIControlStateNormal];
    [_explainButton setImgViewStyle:ButtonImgViewStyleRight imageSize:moreImage.size space:7];
    
    _descriLabel = [[UILabel alloc] init];
    _descriLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _descriLabel.textColor = [UIColor darkGrayColor];
    
    [self addSubview:_titleLabel];
    [self addSubview:_explainButton];
    [self addSubview:_descriLabel];
    
    _titleLabel.text = @"拼团玩法";
    _descriLabel.text = @"开团支付成功后并邀请4人参团,人数不足则自动退款";
}
-(void)addConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(Height_Pt(40));
        make.left.equalTo(self).with.offset(Width_Pt(30));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_descriLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(65));
        make.left.equalTo(self).with.offset(Width_Pt(30));
        make.bottom.equalTo(self).with.offset( - Height_Pt(40));
    }];
    
    [_explainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(self).with.offset( - Width_Pt(30));
        make.width.mas_equalTo(Width_Pt(230));
        make.height.mas_equalTo(Height_Pt(65));
    }];

}

-(RACSignal *)checkRulesSignal {
    return [_explainButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
