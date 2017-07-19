//
//  DDCSTextView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "DDCSTextView.h"

@interface DDCSTextView ()

@property (nonatomic, strong) UITextView *placeholderTextView;

@end

@implementation DDCSTextView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(UITextView *)placeholderTextView {
    if (!_placeholderTextView) {
        _placeholderTextView = [[UITextView alloc] init];
        _placeholderTextView.scrollEnabled = NO;
        _placeholderTextView.showsHorizontalScrollIndicator = NO;
        _placeholderTextView.showsVerticalScrollIndicator = NO;
        _placeholderTextView.userInteractionEnabled = NO;
        _placeholderTextView.font = self.font;
        _placeholderTextView.textColor = [UIColor lightGrayColor];
        //_placeholderTextView.backgroundColor = [UIColor clearColor];
    }
    return _placeholderTextView;
}

-(void)setup {
    
    [self addSubview:self.placeholderTextView];
    
    [self.placeholderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)textDidChange
{
    // 占位文字是否显示
    self.placeholderTextView.hidden = self.text.length > 0;

}

-(void)setPlaceholder:(NSString *)placeholder {
    self.placeholderTextView.text = placeholder;
    
//    self.placeholderTextView.frame = CGRectMake(0, 0, Width, 40);
//    [self.placeholderTextView layoutIfNeeded];
}
-(void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    self.placeholderTextView.textColor = placeholderTextColor;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
