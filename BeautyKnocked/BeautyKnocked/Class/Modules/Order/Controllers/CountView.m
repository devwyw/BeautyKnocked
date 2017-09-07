//
//  CountView.m
//  Technician
//
//  Created by Mac on 2017/8/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "CountView.h"

@interface CountView ()
@property (nonatomic,strong) UIButton * reduce;
@property (nonatomic,strong) UITextField * countText;
@property (nonatomic,strong) UIButton * addTo;
@end

static NSString *reduces=@"reduce";
static NSString *unReduce=@"reduce";
static NSString *addTos=@"addto";
static NSString *unAddTo=@"addto";
@implementation CountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeCornerRadius:3];
        [self makeBorderWidth:1 withColor:[UIColor colorWithHexString:@"#BFBFBF"]];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setCounts:(NSString *)counts{
    _counts=counts;
    _countText.text=counts;
}
-(void)initializeViews {
    /** 减少 */
    _reduce=[[UIButton alloc]init];
    _reduce.userInteractionEnabled=NO;
    [_reduce setImage:[UIImage imageNamed:unReduce] forState:UIControlStateNormal];
    [[_reduce rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([_countText.text integerValue]>1) {
            _countText.text=[NSString stringWithFormat:@"%ld",[_countText.text integerValue]-1];
            if ([_countText.text integerValue]==1) {
                [_reduce setImage:[UIImage imageNamed:unReduce] forState:UIControlStateNormal];
                _reduce.userInteractionEnabled=NO;
            }else{
                [_reduce setImage:[UIImage imageNamed:reduces] forState:UIControlStateNormal];
                _reduce.userInteractionEnabled=YES;
            }
        }
        _counts=_countText.text;
        [_subCounts sendNext:_counts];
        [_addTo setImage:[UIImage imageNamed:addTos] forState:UIControlStateNormal];
        _addTo.userInteractionEnabled=YES;
    }];
    [self addSubview:_reduce];
    
    /** 增加 */
    _addTo=[[UIButton alloc]init];
    _addTo.userInteractionEnabled=YES;
    [_addTo setImage:[UIImage imageNamed:addTos] forState:UIControlStateNormal];
    [[_addTo rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([_countText.text integerValue]<10) {
            _countText.text=[NSString stringWithFormat:@"%ld",[_countText.text integerValue]+1];
            if ([_countText.text integerValue]==10) {
                [_addTo setImage:[UIImage imageNamed:unAddTo] forState:UIControlStateNormal];
                _addTo.userInteractionEnabled=NO;
            }else{
                [_addTo setImage:[UIImage imageNamed:addTos] forState:UIControlStateNormal];
                _addTo.userInteractionEnabled=YES;
            }
        }
        _counts=_countText.text;
        [_subCounts sendNext:_counts];
        [_reduce setImage:[UIImage imageNamed:reduces] forState:UIControlStateNormal];
        _reduce.userInteractionEnabled=YES;
    }];
    [self addSubview:_addTo];
    
    _countText=[[UITextField alloc]init];
    _countText.textAlignment=NSTextAlignmentCenter;
    _countText.keyboardType = UIKeyboardTypeNumberPad;
    _countText.font = [UIFont systemFontOfSize:Font_Size(35)];
    _countText.clearButtonMode = UITextFieldViewModeNever;
    _countText.borderStyle = UITextBorderStyleNone;
    
    [[_countText rac_signalForControlEvents:UIControlEventEditingDidEnd]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([_countText.text integerValue]<=1) {
            _countText.text=@"1";
            [_reduce setImage:[UIImage imageNamed:unReduce] forState:UIControlStateNormal];
            _reduce.userInteractionEnabled=NO;
            [_addTo setImage:[UIImage imageNamed:addTos] forState:UIControlStateNormal];
            _addTo.userInteractionEnabled=YES;
        }else if ([_countText.text integerValue]>=10) {
            _countText.text=@"10";
            [_reduce setImage:[UIImage imageNamed:reduces] forState:UIControlStateNormal];
            _reduce.userInteractionEnabled=YES;
            [_addTo setImage:[UIImage imageNamed:unAddTo] forState:UIControlStateNormal];
            _addTo.userInteractionEnabled=NO;
        }else{
            [_reduce setImage:[UIImage imageNamed:reduces] forState:UIControlStateNormal];
            _reduce.userInteractionEnabled=YES;
            [_addTo setImage:[UIImage imageNamed:addTos] forState:UIControlStateNormal];
            _addTo.userInteractionEnabled=YES;
        }
        if (![_counts isEqualToString:_countText.text]) {
            _counts=_countText.text;
            [_subCounts sendNext:_counts];
        }
    }];
    [self addSubview:_countText];
}
-(void)addConstraints {
    [_reduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Width_Pt(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(40), Height_Pt(40)));
    }];
    [_addTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-Width_Pt(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(40), Height_Pt(40)));
        
    }];
    [_countText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_reduce.mas_right).offset(5);
        make.bottom.equalTo(self);
        make.right.equalTo(_addTo.mas_left).offset(-5);
    }];
}
@end
