//
//  CarItem.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CarItem.h"

@interface CarItem ()
@property (nonatomic,strong) UILabel * carCount;
@property (nonatomic,strong) UIButton * carAction;
@end

@implementation CarItem

-(instancetype)initWithOriginY:(CGFloat)y{
    self = [super initWithFrame:CGRectMake(5, y, 60, 60)];
    if (self) {
        _carAction=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_carAction setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10.5, 10.5)];
        [_carAction setImage:[UIImage imageNamed:@"gouwuche_03"] forState:UIControlStateNormal];
        [self addSubview:_carAction];
        
        _carCount=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        _carCount.text=@"0";
        [_carCount setFont:[UIFont systemFontOfSize:10]];
        [_carCount setTextAlignment:NSTextAlignmentCenter];
        [_carCount setTextColor:[UIColor whiteColor]];
        [_carCount setBackgroundColor:[UIColor blackColor]];
        [_carCount.layer setCornerRadius:11];
        [_carCount.layer setMasksToBounds:YES];
        [_carAction addSubview:_carCount];
    }
    return self;
}
-(RACSignal*)pushCar{
    return [_carAction rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(void)setCount:(NSInteger)count{
    if (count>99) {
        _carCount.text=@"99+";
    }else{
        _carCount.text=[NSString stringWithFormat:@"%ld",count];
    }
}
@end
