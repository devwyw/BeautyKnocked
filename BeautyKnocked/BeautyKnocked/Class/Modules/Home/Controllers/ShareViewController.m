//
//  ShareViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ShareViewController.h"
#import "UIButton+Category.h"
#import "AppDelegate+UShare.h"

@interface ShareViewController ()
@property (nonatomic,strong) UIImageView * popImage;
@end

@implementation ShareViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(Width-Width_Pt(80)-15, 22-Height_Pt(80)/2, Width_Pt(80), Height_Pt(80))];
        [item setTag:104];
        [item setImage:[UIImage imageNamed:@"fenxiang-bai"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    {
        UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:104];
        [item removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"分享有礼"];
    [self loadBackGroundView];
}
#pragma mark ##### SetView #####
-(void)loadBackGroundView{
    UIImageView *backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    [backgroundImage setImage:[UIImage imageNamed:@"fenxiangbj"]];
    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    backgroundImage.clipsToBounds=YES;
    [self.view addSubview:backgroundImage];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(Width_Pt(55), Height-Height_Pt(750), Width-Width_Pt(55)*2, 50)];
    label.numberOfLines=0;
    label.text=@"送给闺蜜25元新人优惠券, 当Ta首次下单后";
    [label setFont:[UIFont italicSystemFontOfSize:Font_Size(40)]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(backgroundImage).offset(Height_Pt(925));
        make.left.equalTo(backgroundImage).offset(Width_Pt(115));
        make.right.equalTo(backgroundImage).offset(-Width_Pt(115));
    }];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake((Width-230)/2, label.frame.origin.y+50+10, 230, 22)];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"您可获得25元奖励"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(4, 3)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(50)] range:NSMakeRange(0, AttributedStr.length)];
    [AttributedStr addAttribute:NSKernAttributeName value:@(3) range:NSMakeRange(0, AttributedStr.length)];
    [label1 setAttributedText:AttributedStr];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(label.mas_bottom).offset(Height_Pt(35));
    }];
    
    /** 奖励细则 */
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((Width-50)/2, label1.frame.origin.y+22+10, 55, 15)];
    
    NSMutableAttributedString* normalStr = [[NSMutableAttributedString alloc] initWithString:@"奖励细则"];
    [normalStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:(NSRange){0,[normalStr length]}];
    [normalStr addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor]  range:NSMakeRange(0,[normalStr length])];
    [normalStr addAttribute:NSUnderlineColorAttributeName value:[UIColor brownColor] range:NSMakeRange(0,[normalStr length])];
    [normalStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(35)] range:NSMakeRange(0, normalStr.length)];
    
    NSMutableAttributedString* HighStr = [[NSMutableAttributedString alloc] initWithString:@"奖励细则"];
    [HighStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:(NSRange){0,[HighStr length]}];
    [HighStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]  range:NSMakeRange(0,[HighStr length])];
    [HighStr addAttribute:NSUnderlineColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,[HighStr length])];
    [HighStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(35)] range:NSMakeRange(0, HighStr.length)];
    
    [button setAttributedTitle:normalStr forState:UIControlStateNormal];
    [button setAttributedTitle:HighStr forState:UIControlStateHighlighted];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master PopAlertView:_popImage];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(label1.mas_bottom).offset(Height_Pt(35));
    }];
    
    NSArray *imageArr=@[@"weixin-fenxiang",@"pengyouquan-fenxiang",@"QQ-fenxiang",@"duanxinfenxiang"];
    NSArray *titleArr=@[@"微信好友",@"朋友圈",@"QQ好友",@"手机短信"];
    for (int i=1; i<=4; i++) {
        UIButton *Sbutton=[[UIButton alloc]initWithFrame:CGRectMake((Width-Width_Pt(180)*4)/5*i+(i-1)*Width_Pt(180),Height-Height_Pt(210)-30, Width_Pt(180), Height_Pt(210))];
        
        [Sbutton setTag:104+i];
        [Sbutton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
        [Sbutton.titleLabel setFont:[UIFont systemFontOfSize:Font_Size(35)]];
        [Sbutton setTitle:titleArr[i-1] forState:UIControlStateNormal];
        [Sbutton setImage:[UIImage imageNamed:imageArr[i-1]] forState:UIControlStateNormal];
        [Sbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Sbutton setImgViewStyle:ButtonImgViewStyleTop imageSize:[UIImage imageNamed:imageArr[i-1]].size space:10];
        [self.view addSubview:Sbutton];
    }
    
    /** 奖励细则弹框 */
    _popImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bj"]];
    _popImage.userInteractionEnabled=YES;
    [_popImage setFrame:CGRectMake(0, 0, Width-Width_Pt(180), Height_Pt(1235))];
    
    UIButton *iKnow=[[UIButton alloc]init];
    [iKnow setBackgroundImage:[UIImage imageNamed:@"wozhidaole"] forState:UIControlStateNormal];
    [[iKnow rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master RemovePopViewWithBlock:nil];
    }];
    [_popImage addSubview:iKnow];
    [iKnow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_popImage.mas_bottom).offset(-Height_Pt(40));
        make.centerX.equalTo(_popImage);
        make.size.sizeOffset(CGSizeMake(Width_Pt(409), Height_Pt(111)));
    }];
    
    UITextView *messageView=[[UITextView alloc]init];
    [messageView setTextColor:[UIColor blackColor]];
    messageView.font=[UIFont systemFontOfSize:Font_Size(35)];
    [messageView setEditable:NO];
    [messageView setText:@"1.如果您的闺蜜从未在美丽敲敲门APP平台下单，则可以领取您分享的“闺蜜25元优惠券”，优惠券有效期为一个月；\n\n2.您的闺蜜只要完成领券后在一个月内消费并使用了本次活动优惠券，您可以领取25元代金券，该优惠券实时到账，可在“我的优惠券”中查看，使用期限为一个月；\n\n3.分享有礼可根据人数进行累加；\n\n4.拥有相同账户（手机号、设备、银行卡、支付账户）均视为同一用户，仅对首次在APP下单的闺蜜及分享者进行返券活动；\n\n5.一经发现任何违规获取美丽敲敲门优惠券的行为， 不予发放任何优惠券，追究法律责任。"];
    [_popImage addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_popImage).offset(Width_Pt(70));
        make.right.equalTo(_popImage).offset(-Width_Pt(70));
        make.bottom.equalTo(iKnow.mas_top).offset(-Height_Pt(45));
        make.height.offset(Height_Pt(623));
    }];
    
    UILabel *popTitle=[[UILabel alloc]init];
    popTitle.text=@"活动细则";
    popTitle.font=[UIFont boldSystemFontOfSize:Font_Size(60)];
    [_popImage addSubview:popTitle];
    [popTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_popImage);
        make.bottom.equalTo(messageView.mas_top).offset(-Height_Pt(65));
    }];
}
-(void)share:(UIButton*)button{
    [AppDelegate popShareSheetViewWithMessage:@"这是一段分享测试内容"];
}
-(void)shareButton:(UIButton*)button{
    switch (button.tag) {
        case 105:
        {
            NSLog(@"微信好友");
        }
            break;
        case 106:
        {
            NSLog(@"朋友圈");
        }
            break;
        case 107:
        {
            NSLog(@"QQ");
        }
            break;
        case 108:
        {
            NSLog(@"短信");
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
