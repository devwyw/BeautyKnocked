//
//  ShareViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@property (nonatomic,strong) UIView * Jview;

@end

@implementation ShareViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    {
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
//        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
//        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//        [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    }
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
    [super viewWillDisappear:YES];
//    {
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
//        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//        [self.navigationController.navigationBar setBarTintColor:ThemeColor];
//        [self.navigationController.navigationBar setBackgroundColor:ThemeColor];
//    }
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
    [self.view addSubview:backgroundImage];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(Width_Pt(55), Height-Height_Pt(750), Width-Width_Pt(55)*2, 50)];
    label.numberOfLines=0;
    label.text=@"送给闺蜜25元新人优惠券, 当Ta首次下单后";
    [label setTextColor:[UIColor darkGrayColor]];
    [label setFont:[UIFont italicSystemFontOfSize:Font_Size(36)]];
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
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(52)] range:NSMakeRange(0, AttributedStr.length)];
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
    [normalStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(30)] range:NSMakeRange(0, normalStr.length)];
    
    NSMutableAttributedString* HighStr = [[NSMutableAttributedString alloc] initWithString:@"奖励细则"];
    [HighStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:(NSRange){0,[HighStr length]}];
    [HighStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]  range:NSMakeRange(0,[HighStr length])];
    [HighStr addAttribute:NSUnderlineColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,[HighStr length])];
    [HighStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:Font_Size(30)] range:NSMakeRange(0, HighStr.length)];
    
    [button setAttributedTitle:normalStr forState:UIControlStateNormal];
    [button setAttributedTitle:HighStr forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(JLmessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(label1.mas_bottom).offset(Height_Pt(35));
    }];
    
    NSArray *imageArr=@[@"weixin-fenxiang",@"pengyouquan-fenxiang",@"QQ-fenxiang",@"duanxinfenxiang"];
    NSArray *titleArr=@[@"微信好友",@"朋友圈",@"QQ好友",@"手机短信"];
    for (int i=1; i<=4; i++) {
        UIButton *Sbutton=[[UIButton alloc]initWithFrame:CGRectMake((Width-Width_Pt(180)*4)/5*i+(i-1)*Width_Pt(180),Height-Height_Pt(210)-10, Width_Pt(180), Height_Pt(210))];
        
        [Sbutton setTag:104+i];
        [Sbutton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
        [Sbutton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [Sbutton setTitle:titleArr[i-1] forState:UIControlStateNormal];
        [Sbutton setImage:[UIImage imageNamed:imageArr[i-1]] forState:UIControlStateNormal];
        [Sbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Sbutton setImagePosition:LXMImagePositionTop spacing:5];
        [self.view addSubview:Sbutton];
    }
    
//    /** 奖励细则弹框 */
    _Jview =[[UIView alloc]initWithFrame:ViewMake];
    [_Jview setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.3]];
    [self.view addSubview:_Jview];
    
    UIImageView * Jimage=[[UIImageView alloc]init];
    [Jimage setImage:[UIImage imageNamed:@"bj"]];
    [Jimage setContentMode:UIViewContentModeScaleAspectFill];
    [_Jview addSubview:Jimage];
    [Jimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(_Jview).offset(25);
        make.right.equalTo(_Jview).offset(-25);
        make.width.mas_equalTo(Width_Pt(902));
        make.height.mas_equalTo(Height_Pt(1236));
    }];
    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"活动细则";
    [title setFont:[UIFont boldSystemFontOfSize:Font_Size(60)]];
    [title setTextColor:[UIColor blackColor]];
    title.numberOfLines=0;
    [Jimage addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Jimage);
        make.top.equalTo(Jimage.mas_top).offset(Height_Pt(290));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(300), Height_Pt(80)));
    }];
    
    UIButton *zhidao=[[UIButton alloc]init];
    [zhidao setImage:[UIImage imageNamed:@"wozhidaole"] forState:UIControlStateNormal];
    [zhidao addTarget:self action:@selector(zhidao:) forControlEvents:UIControlEventTouchUpInside];
    [_Jview addSubview:zhidao];
    [zhidao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Jimage);
        make.bottom.equalTo(Jimage.mas_bottom).offset(-Height_Pt(40));
        make.width.height.mas_equalTo(CGSizeMake(Width_Pt(440), Height_Pt(145)));
    }];
    
}
-(void)share:(UIButton*)button{
    NSLog(@"分享");
}
-(void)JLmessage:(UIButton*)button{
    [_Jview setHidden:NO];
}
-(void)zhidao:(UIButton*)button{
    [_Jview setHidden:YES];
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
