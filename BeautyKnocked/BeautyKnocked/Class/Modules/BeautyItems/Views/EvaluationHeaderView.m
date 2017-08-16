//
//  EvaluationHeaderView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/3.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationHeaderView.h"
#import "UIButton+Category.h"


@interface EvaluationHeaderView ()
@property (nonatomic, strong) UILabel *evalutionCountLabel;
@property (nonatomic, strong) UIButton *checkAllEvalutionButton;
@end

@implementation EvaluationHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setListCount:(NSString *)listCount{
    _evalutionCountLabel.text = [NSString stringWithFormat:@"用户评论(%@)",listCount];
}
-(void)initializeViews {
    _evalutionCountLabel = [[UILabel alloc] init];
    _evalutionCountLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _checkAllEvalutionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkAllEvalutionButton setTitle:@"查看全部" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"gengduo"];
    [_checkAllEvalutionButton setImage:image forState:UIControlStateNormal];
    [_checkAllEvalutionButton setImgViewStyle:ButtonImgViewStyleRight imageSize:image.size space:5];
    [_checkAllEvalutionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _checkAllEvalutionButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_evalutionCountLabel];
    [self addSubview:_checkAllEvalutionButton];
    
}
-(void)addConstraints {
    [_evalutionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.centerY.equalTo(self);
        //make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_checkAllEvalutionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_evalutionCountLabel);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.height.mas_equalTo(Height_Pt(45));
        make.width.mas_equalTo(Width_Pt(200));
    }];

}

-(RACSignal *)checkAllEvaluationSignal {
    return [_checkAllEvalutionButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
