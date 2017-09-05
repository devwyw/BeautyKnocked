//
//  AddAndReserveView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddAndReserveView.h"
#import "UIButton+Category.h"

@interface AddAndReserveView ()

@property (nonatomic, strong) UIButton *addShoppingCart;
@property (nonatomic, strong) UIButton *appointNow;

@end

@implementation AddAndReserveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setType:(NSString *)type{
    switch ([type integerValue]) {
        case 0:
        {
            [_appointNow setTitle:@"立即预约" forState:UIControlStateNormal];
            [_appointNow makeCornerRadius:8];
            [_appointNow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(Width/2);
                make.top.bottom.equalTo(self);
                make.centerX.equalTo(self);
            }];
        }
            break;
        case 1:
        {
            [_appointNow setTitle:@"立即购买" forState:UIControlStateNormal];
            [_appointNow makeCornerRadius:8];
            [_appointNow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(Width/2);
                make.top.bottom.equalTo(self);
                make.centerX.equalTo(self);
            }];
        }
            break;
        default:
            [_appointNow setTitle:@"立即购买" forState:UIControlStateNormal];
            
            _addShoppingCart = [UIButton buttonWithType:UIButtonTypeCustom];
            _addShoppingCart.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
            [_addShoppingCart setBackgroundImage:[UIImage imageNamed:@"gouwuchekuang"] forState:UIControlStateNormal];
            [_addShoppingCart setTitle:@"加入购物车" forState:UIControlStateNormal];
            [_addShoppingCart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_addShoppingCart setImage:[UIImage imageNamed:@"jiarugouwuche"] forState:UIControlStateNormal];
            [_addShoppingCart setImgViewStyle:ButtonImgViewStyleLeft imageSize:[UIImage imageNamed:@"jiarugouwuche"].size space:5];
            [self addSubview:_addShoppingCart];
            [_addShoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, Width/2));
            }];
            
            [_appointNow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, Width/2, 0, 0));
            }];
            break;
    }
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initializeButtons];
    }
    return self;
}

-(void)initializeButtons {
    _appointNow = [UIButton buttonWithType:UIButtonTypeCustom];
    _appointNow.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_appointNow setBackgroundImage:[UIImage imageNamed:@"yuyuekuang"] forState:UIControlStateNormal];
    [self addSubview:_appointNow];
}
-(RACSignal *)reserveNowSignal {
    return [_appointNow rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)addCar{
    return [_addShoppingCart rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
