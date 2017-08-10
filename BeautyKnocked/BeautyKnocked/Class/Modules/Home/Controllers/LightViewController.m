//
//  LightController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LightViewController.h"
#import "LightSonViewController.h"

@interface LightViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIScrollView *Sview;

@property (nonatomic,strong) UITextField * text1;
@property (nonatomic,strong) UITextField * text2;
@property (nonatomic,strong) UIView * textView;

@end

@implementation LightViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"光电中心"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];//关闭自动布局
    [self loadScrollVeiw];
    [self addButton];
    // Do any additional setup after loading the view.
}
-(void)loadScrollVeiw{
    _Sview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    [_Sview setContentSize:CGSizeMake(Width_Pt(1080), Height_Pt(4939))];
    _Sview.delaysContentTouches = NO;
    [self.view addSubview:_Sview];
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(1080), Height_Pt(4939))];
    [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lightimage.jpg"]]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [_Sview addSubview:image];
}
-(void)addButton{
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(1421), 80, Height_Pt(65))];
        [button setTag:1];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(1980), 80, Height_Pt(65))];
        [button setTag:2];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(2550), 80, Height_Pt(65))];
        [button setTag:3];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(3030), 80, Height_Pt(65))];
        [button setTag:4];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(3690), 80, Height_Pt(65))];
        [button setTag:5];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(4205), 80, Height_Pt(65))];
        [button setTag:6];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        /** 遮盖图片输入框 */
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(50, Height_Pt(4939)-Height_Pt(542), Width-100, Height_Pt(245))];
        [view setBackgroundColor:[UIColor whiteColor]];
        [_Sview addSubview:view];
        
        /** 提交预约 */
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(50, Height_Pt(4939)-Height_Pt(258), Width-100, Height_Pt(121))];
        [button addTarget:self action:@selector(pushOk:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
        
        _textView=[[UIView alloc]initWithFrame:CGRectMake(50, Height_Pt(4939)-Height_Pt(542), Width-100, Height_Pt(245))];
        [_textView setBackgroundColor:[UIColor whiteColor]];
        [_textView makeCornerRadius:8];
        [_textView makeBorderWidth:1 withColor:[UIColor colorWithHexString:@"#F27D9B"]];
        [_Sview addSubview:_textView];
        
        _text1=[[UITextField alloc]initWithFrame:CGRectMake(5, 5, Width-110, Height_Pt(245)/2-10)];
        _text1.font = [UIFont systemFontOfSize:14.0f];
        _text1.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_text1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _text1.placeholder = @"请输入姓名";
        _text1.borderStyle = UITextBorderStyleRoundedRect;
        [_textView addSubview:_text1];
        
        _text2=[[UITextField alloc]initWithFrame:CGRectMake(5, _text1.frame.origin.y+_text1.frame.size.height+10, Width-110,_text1.frame.size.height)];
        _text2.font = [UIFont systemFontOfSize:14.0f];
        _text2.delegate=self;
        _text2.keyboardType = UIKeyboardTypeNumberPad;
        _text2.clearButtonMode = UITextFieldViewModeWhileEditing;
        _text2.placeholder = @"请输入电话号码";
        _text2.borderStyle = UITextBorderStyleRoundedRect;
        [_textView addSubview:_text2];
    }
}
-(void)pushSon:(UIButton*)button{
    LightSonViewController *controller=[[LightSonViewController alloc]init];
    [controller setMtag:button.tag];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)pushOk:(UIButton*)button{
    NSLog(@"%@-%@",_text1.text,_text2.text);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"预约成功" message:@"非常感谢您的预约，我们会尽快处理" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= 10) {
            textField.text = [textField.text substringToIndex:10];
    }
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    int length = 4;//限制的字数
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position || !selectedRange)
        {
            if (toBeString.length > length)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:length];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:length];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, length)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else{
        if (textField.text.length >=11) {
            textField.text=[textField.text substringToIndex:11];
        }
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
