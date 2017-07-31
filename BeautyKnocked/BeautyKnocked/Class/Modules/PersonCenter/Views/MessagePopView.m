//
//  MessagePopView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MessagePopView.h"

@interface MessagePopView ()
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIButton * cancel;
@property (nonatomic,strong) UITextView * textview;
@property (nonatomic,strong) UIButton * done;
@end

@implementation MessagePopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = MMPopupTypeAlert;
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _title=[[UILabel alloc]init];
    _title.text=@"反馈";
    _title.font=[UIFont systemFontOfSize:Font_Size(55)];
    [self addSubview:_title];
    
    _cancel=[[UIButton alloc]init];
    //qu-xiao
    [self addSubview:_cancel];
    
    _textview=[[UITextView alloc]init];
    [self addSubview:_textview];
    
    _done=[[UIButton alloc]init];
    [self addSubview:_done];
}
-(void)addConstraints {
    
}



@end
