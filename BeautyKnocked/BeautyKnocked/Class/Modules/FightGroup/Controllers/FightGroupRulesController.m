//
//  FightGroupRulesController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupRulesController.h"
#import "FightGroupRulesTitleView.h"

@interface FightGroupRulesController ()

@property (nonatomic, strong) FightGroupRulesTitleView *titleView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation FightGroupRulesController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.title = @"拼团规则说明";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initializeViews];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeViews {
    _titleView = [[FightGroupRulesTitleView alloc] init];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"（1）开团：第一个人购买商品并完成支付后，该团即刻生成。\n（2）邀请好友参团：开团后团员即可将链接分享给好友，购买该商品的好友成为参团成员。\n（3）取消订单：拼团订单支付成功后不支持取消订单。\n（4）拼团成功：规定每月的1-10号为拼团项目开放时间，开团后24小时内达到规定的人数（5人成团），即可拼团成功，用户可在我的拼团-拼团成功页面领取项目优惠券，再预约该项目并选择使用优惠券。\n（5）拼团失败：开团24小时内未能找到相应人数的好友参团，该团失败，系统自动退款。\n（6）优惠券适用：拼团商品不支持任何优惠券。\n（7）拼团项目：系统每月只推出一种项目作为拼团商品，周期10天。\n（8）拼团限购：用户每月只可参与一次拼团。"];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(40)] range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment=NSTextAlignmentLeft;
    style.lineSpacing = 5;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    _contentLabel.attributedText=text;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_titleView];
    [_scrollView addSubview:_contentLabel];
}
-(void)addConstraints {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView).with.offset(Height_Pt(40));
        make.left.and.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
        make.height.mas_equalTo(Height_Pt(60));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom).with.offset(Height_Pt(45));
        make.left.equalTo(_scrollView).with.offset(10);
        make.right.equalTo(_scrollView).with.offset( - 10);
        make.width.mas_equalTo(Width - 10*2);
        make.bottom.equalTo(_scrollView);
    }];
    
}

@end
