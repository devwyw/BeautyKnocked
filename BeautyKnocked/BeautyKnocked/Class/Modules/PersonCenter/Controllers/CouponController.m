//
//  CouponController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponController.h"
#import "SonCouponTableController.h"
#import "CouponInfoController.h"

@interface CouponController ()
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,strong) UIButton * item;
@end

NSInteger number1=0;
NSInteger number2=0;
NSInteger number3=0;

@implementation CouponController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        _item = [[UIButton alloc]initWithFrame:CGRectMake(Width-80, 2, 70, 40)];
        [_item setTag:101];
        _item.titleLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
        [_item setTitle:@"使用说明" forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        Weakify(self);
        [[_item rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            CouponInfoController *controller=[[CouponInfoController alloc]init];
            [Wself.navigationController pushViewController:controller animated:YES];
        }];
        [self.navigationController.navigationBar addSubview:_item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item removeFromSuperview];
}
-(NSMutableArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的优惠券";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    [self loadHttp];
    // Do any additional setup after loading the view.
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleSizeSelected = Font_Size(40);
        self.titleSizeNormal = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight=Height_Pt(120);
        self.menuBGColor=[UIColor whiteColor];
        self.menuViewBottomSpace=0.6;
        self.menuItemWidth = Width / 3;
        self.progressColor=[UIColor colorWithHexString:@"#E1BF6E"];
        self.titleColorNormal=[UIColor blackColor];
        self.titleColorSelected=self.titleColorNormal;
    }
    return self;
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SonCouponTableController *controller=[[SonCouponTableController alloc]init];
    if (self.listArray.count==3) {
        controller.listArray=[[NSMutableArray alloc]initWithArray:self.listArray[index]];
    }
    return controller;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[[NSString stringWithFormat:@"未使用 %ld",number1],[NSString stringWithFormat:@"已使用 %ld",number2],[NSString stringWithFormat:@"已过期 %ld",number3]][index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ===== 优惠券列表 =====
-(void)loadHttp{
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:khyhqlb Success:^(id json) {
        NSMutableArray *arr1=[[NSMutableArray alloc]init];
        NSMutableArray *arr2=[[NSMutableArray alloc]init];
        NSMutableArray *arr3=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in json[@"info"]) {
            switch ([dic[@"status"] integerValue]) {
                case 0:
                    [arr1 addObject:dic];
                    break;
                case 1:
                    [arr2 addObject:dic];
                    break;
                default:
                    [arr3 addObject:dic];
                    break;
            }
        }
        number1=arr1.count;
        number2=arr2.count;
        number3=arr3.count;
        [self.listArray addObject:arr1];
        [self.listArray addObject:arr2];
        [self.listArray addObject:arr3];
        [self reloadData];
    } Failure:nil andNavigation:self.navigationController];
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
