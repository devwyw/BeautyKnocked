//
//  IntegralSectionHeaderView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntegralSectionHeaderView.h"
#import "IntegralBalanceView.h"
#import "UIButton+Category.h"

@interface IntegralSectionHeaderView ()
@property (nonatomic, strong) IntegralBalanceView *integralView;
@property (nonatomic, strong) UIButton *recordingButton;
@property (nonatomic, strong) UIView *line;
@end
@implementation IntegralSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)setIntegralBalance:(NSString *)integralBalance {

    _integralView.bablance = integralBalance;
}

-(void)initializeViews {
    
    _integralView = [[IntegralBalanceView alloc] init];
    
    _recordingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recordingButton setTitle:@"兑换记录" forState:UIControlStateNormal];
    [_recordingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"jilu"];
    [_recordingButton setImage:image forState:UIControlStateNormal];
    [_recordingButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:image.size space:8];
    _recordingButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:_integralView];
    [self addSubview:_recordingButton];
    [self addSubview:_line];
    
}
-(void)addConstraints {
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(self);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(Height_Pt(64));
    }];
    
    [_integralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(_line.mas_left).with.offset( - 10);
        make.centerY.equalTo(self);
        make.height.equalTo(_line);
    }];
    
    [_recordingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset( - 10);
        make.left.equalTo(_line.mas_left).with.offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(_recordingButton);
    }];
    
}

-(RACSignal *)recordingSignal {
    return [_recordingButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
