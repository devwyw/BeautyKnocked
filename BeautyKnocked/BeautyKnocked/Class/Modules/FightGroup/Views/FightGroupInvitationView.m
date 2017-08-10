//
//  FightGroupInvitationView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupInvitationView.h"
#import "FightGroupHourglassShareView.h"


@interface FightGroupInvitationView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) FightGroupHourglassShareView *inviteView;
@property (nonatomic, strong) UIButton *rulesButton;

@end
@implementation FightGroupInvitationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    
    _inviteView = [[FightGroupHourglassShareView alloc] init];
    _inviteView.textColor = [UIColor whiteColor];
    NSString *time = @"18 小时 18 分 30 秒";
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:time];
    NSDictionary *dict = @{NSBackgroundColorAttributeName:[UIColor whiteColor],NSForegroundColorAttributeName:[UIColor orangeColor]};
    [attributeString addAttributes:dict range:NSMakeRange(0, 2)];
    [attributeString addAttributes:dict range:NSMakeRange(6, 2)];
    [attributeString addAttributes:dict range:NSMakeRange(11, 2)];
    _inviteView.hourglass = attributeString;
    
    NSMutableAttributedString *people = [[NSMutableAttributedString alloc] initWithString:@"还差4人,赶快邀请好友来参团吧"];
    [people addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(2, 1)];
    _inviteView.people = people;
    
    Weakify(self)
    [_inviteView setFightGroupShareBlock:^(NSUInteger shareIndex){
        if ([Wself.delegate respondsToSelector:@selector(didSelectShareStyle:)]) {
            [Wself.delegate didSelectShareStyle:shareIndex];
        }
    }];
    
    _rulesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rulesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rulesButton setTitle:@"拼团规则" forState:UIControlStateNormal];
    _rulesButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_rulesButton setImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    gesture.cancelsTouchesInView = NO;
    gesture.delegate = self;
    
    
    [self addGestureRecognizer:gesture];
    
    [self addSubview:_inviteView];
    [self addSubview:_rulesButton];
    
}
-(void)addConstraints {
    [_inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(720));
    }];
    
    [_rulesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).with.offset( - Height_Pt(60));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(235), Height_Pt(46)));
    }];
}

- (void)actionTap:(UITapGestureRecognizer*)gesture {
    NSLog(@"点击了");
    
    [UIView animateWithDuration:0.6 animations:^{
        [self removeFromSuperview];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (touch.view == self);
}

-(void)showInView:(UIView *)view {
    if (view) {
        [view addSubview:self];
    }
}

-(RACSignal *)rulesSignal {
    return [_rulesButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
