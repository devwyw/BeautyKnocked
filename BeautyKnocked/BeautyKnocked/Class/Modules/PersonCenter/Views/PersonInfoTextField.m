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

-(void)createViews {
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor lightGrayColor];
    _textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [self addSubview:_textLabel];
    
    _textField = [[UITextField alloc] init];
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
