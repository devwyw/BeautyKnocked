//
//  AddCarView.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddCarView.h"

@interface AddCarView ()
@property (nonatomic,strong) UILabel * number;
@property (nonatomic,strong) UIButton * Lbtn;
@property (nonatomic,strong) UIButton * Rbtn;
@end

@implementation AddCarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGView];
    }
    return self;
}
-(void)addGView{
    UIView *backview=[[UIView alloc]init];
    backview.backgroundColor=[UIColor whiteColor];
    [self addSubview:backview];
    
    UIImageView *image=[[UIImageView alloc]init];
    [image makeCornerRadius:8];
    image.contentMode=UIViewContentModeScaleAspectFill;
    image.clipsToBounds=YES;
    [image setImage:[UIImage imageNamed:@"jiaruchanpin"]];
    [self addSubview:image];
    
    UIButton *done=[[UIButton alloc]init];
    [done setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
    [done setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:done];
    
    UILabel *Jlabel=[[UILabel alloc]init];
    Jlabel.text=[NSString stringWithFormat:@"市场价：¥%d",45];
    [Jlabel setTextColor:[UIColor colorWithHexString:@"#FE016E"]];
    [self addSubview:Jlabel];
    
    UILabel *Klabel=[[UILabel alloc]init];
    Klabel.text=[NSString stringWithFormat:@"库存%d件",2273];
    [Klabel setTextColor:[UIColor blackColor]];
    [Klabel setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:Klabel];
    
    UILabel *Slabel=[[UILabel alloc]init];
    Slabel.text=@"数量";
    [Slabel setTextColor:[UIColor blackColor]];
    [self addSubview:Slabel];
    
    UIView *line=[[UIView alloc]init];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:line];
    
    _Lbtn=[[UIButton alloc]init];
    [_Lbtn setImage:[UIImage imageNamed:@"bukejian"] forState:UIControlStateNormal];
    [_Lbtn addTarget:self action:@selector(setNum:) forControlEvents:UIControlEventTouchUpInside];
    _Lbtn.userInteractionEnabled=NO;
    [self addSubview:_Lbtn];
    
    _Rbtn=[[UIButton alloc]init];
    [_Rbtn setImage:[UIImage imageNamed:@"kejia"] forState:UIControlStateNormal];
    [_Rbtn addTarget:self action:@selector(setNum:) forControlEvents:UIControlEventTouchUpInside];
    _Rbtn.userInteractionEnabled=YES;
    [self addSubview:_Rbtn];
    
    _number=[[UILabel alloc]init];
    _number.text=@"1";
    _number.backgroundColor=[UIColor colorWithHexString:@"#EEEEEE"];
    _number.textAlignment=NSTextAlignmentCenter;
    [_number makeCornerRadius:8];
    [self addSubview:_number];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Height_Pt(50));
        make.left.bottom.right.equalTo(self);
    }];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(Width_Pt(60));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(305), Height_Pt(305)));
    }];
    
    [done mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(145));
        make.bottom.equalTo(self);
    }];
    
    [Jlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backview).offset(Height_Pt(95));
        make.left.equalTo(image.mas_right).offset(Width_Pt(42));
    }];
    
    [Klabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Jlabel.mas_bottom).offset(10);
        make.left.equalTo(Jlabel.mas_left);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_bottom).offset(Height_Pt(43));
        make.left.equalTo(self).offset(Width_Pt(60));
        make.right.equalTo(self).offset(-Width_Pt(60));
        make.height.mas_equalTo(0.5);
    }];
    
    [Slabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Height_Pt(62));
        make.left.equalTo(line);
    }];
    
    [_Lbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Height_Pt(53));
    }];
    
    [_Rbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Height_Pt(53));
        make.right.equalTo(self.mas_right).offset(-Width_Pt(70));
    }];
    
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(Height_Pt(53));
        make.left.equalTo(_Lbtn.mas_right).offset(Width_Pt(12));
        make.right.equalTo(_Rbtn.mas_left).offset(-Width_Pt(12));
        make.height.equalTo(_Lbtn.mas_height);
        make.width.mas_equalTo(Width_Pt(135));
    }];
}
-(void)setNum:(UIButton*)btn{
    if (btn==_Lbtn) {
        if ([_number.text integerValue]-1>0) {
            _number.text=[NSString stringWithFormat:@"%ld",[_number.text integerValue]-1];
            if ([_number.text integerValue]==1) {
                [_Lbtn setImage:[UIImage imageNamed:@"bukejian"] forState:UIControlStateNormal];
                _Lbtn.userInteractionEnabled=NO;
            }else{
                [_Lbtn setImage:[UIImage imageNamed:@"kejian"] forState:UIControlStateNormal];
                _Lbtn.userInteractionEnabled=YES;
            }
            [_Rbtn setImage:[UIImage imageNamed:@"kejia"] forState:UIControlStateNormal];
            _Rbtn.userInteractionEnabled=YES;
        }
    }else{
        if ([_number.text integerValue]+1<100) {
            _number.text=[NSString stringWithFormat:@"%ld",[_number.text integerValue]+1];
            if ([_number.text integerValue]==99) {
                [_Rbtn setImage:[UIImage imageNamed:@"bukejia"] forState:UIControlStateNormal];
                _Rbtn.userInteractionEnabled=NO;
            }else{
                [_Rbtn setImage:[UIImage imageNamed:@"kejia"] forState:UIControlStateNormal];
                _Rbtn.userInteractionEnabled=YES;
            }
            [_Lbtn setImage:[UIImage imageNamed:@"kejian"] forState:UIControlStateNormal];
            _Lbtn.userInteractionEnabled=YES;
        }
    }
}
@end
