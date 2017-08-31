//
//  StartImageController.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "StartImageController.h"
#import "TabBarController.h"
#import <SDCycleScrollView.h>
#import "UIView+CornerRadius.h"

@interface StartImageController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView * startImage;
@property (nonatomic,strong) UIButton * startRun;
@end

@implementation StartImageController
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.startImage];
}
-(SDCycleScrollView*)startImage{
    if (!_startImage) {
        _startImage=[SDCycleScrollView cycleScrollViewWithFrame:self.view.bounds imageNamesGroup:@[@"y1.jpg",@"y2.jpg",@"y3.jpg",@"y4.jpg"]];
        _startImage.delegate=self;
        _startImage.infiniteLoop=NO;
        _startImage.autoScroll=NO;
        _startImage.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
        
        _startRun=[[UIButton alloc]init];
        [_startRun setTitle:@"开启2.0全新体验" forState:UIControlStateNormal];
        _startRun.titleLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
        [_startRun makeBorderWidth:1 withColor:[UIColor whiteColor]];
        [_startRun makeCornerRadius:Height_Pt(45)];
        [[_startRun rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[TabBarController alloc]init]];
        }];
        _startRun.hidden=YES;
        [_startImage addSubview:_startRun];
        
        [_startRun mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_startImage);
            make.bottom.equalTo(_startImage).offset(-Height_Pt(150));
            make.size.sizeOffset(CGSizeMake(Width_Pt(410), Height_Pt(90)));
        }];
    }
    return _startImage;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    if (index==3) {
        [UIView animateWithDuration:1 animations:^{
            _startRun.hidden=NO;
        }];
    }else{
        _startRun.hidden=YES;
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
