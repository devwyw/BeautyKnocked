//
//  PersonInfoTextField.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PersonInfoTextField.h"

@interface PersonInfoTextField ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation PersonInfoTextField

- (void)drawRect:(CGRect)rect
{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 211/255.0, 211/255.0, 211/255.0, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画笔移动到点(31,170)
    CGContextMoveToPoint(context, 0, Height_Pt(147));
    //下一点
    CGContextAddLineToPoint(context, 0, Height_Pt(147));
    //下一点
    CGContextAddLineToPoint(context, Width, Height_Pt(147));
    //绘制完成
    CGContextStrokePath(context);
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createViews];
        [self addConstraints];
    }
    return self;
}

-(void)setTextName:(NSString *)textName {
    _textLabel.text = textName;
}
-(void)setText:(NSString *)text{
    _textField.text=text;
}
-(void)createViews {
    Acount *user=[Acount shareManager];
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_textLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.text=user.nickName;
    [[_textField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (![_textField.text isEqualToString:user.nickName] && _textField.text.length>0) {
            [Master HttpPostRequestByParams:@{@"id":user.id,@"device":UUID,@"nickName":_textField.text} url:mlqqm serviceCode:ggnc Success:^(id json) {
                user.nickName=_textField.text;
                [user UpdateAcount];
            } Failure:nil];
        }else{
            _textField.text=user.nickName;
        }
    }];
    [self addSubview:_textField];
}

-(void)addConstraints {
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(75));
        make.centerY.equalTo(self);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(372));
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(64));
    }];
}

@end
