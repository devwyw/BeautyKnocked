//
//  AddressEditView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddressEditView.h"

@interface AddressEditView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation AddressEditView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
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
    CGContextMoveToPoint(context, Width_Pt(50), Height_Pt(134));
    //下一点
    CGContextAddLineToPoint(context, Width_Pt(50), Height_Pt(134));
    //下一点
    CGContextAddLineToPoint(context, Width - Width_Pt(50), Height_Pt(134));
    //绘制完成
    CGContextStrokePath(context);

}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [self addSubview:_nameLabel];
    [self addSubview:_textField];
    
}
-(void)addConstraints {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(50));
        make.centerY.equalTo(self);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(298));
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset( - Width_Pt(50));
    }];
}

-(void)setTitle:(NSString *)title {
    _nameLabel.text = title;
}
-(void)setContent:(NSString *)content {
    _textField.text = content;
}
-(void)setPlaceholder:(NSString *)placeholder {
    _textField.placeholder = placeholder;
}

-(NSString *)content {
    return _textField.text;
}

@end
