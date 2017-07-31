//
//  PersonInfoViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "ModifyPersonInfoView.h"
#import "ModifyPasswordController.h"
#import "PersonInfoViewModel.h"

@interface PersonInfoViewController ()

@property (nonatomic, strong) ModifyPersonInfoView *modifyInfoView;

@property (nonatomic, strong) PersonInfoViewModel *personInfoViewModel;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor =  [UIColor colorWithHexString:@"#F0F0F0"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createViews];
    [self addConstraints];
    [self dealSignals];
    
}

-(void)createViews {
    self.modifyInfoView = [[ModifyPersonInfoView alloc] init];
    self.modifyInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.modifyInfoView];
}

-(void)addConstraints {
    [self.modifyInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(809));
    }];
}

-(void)dealSignals {
    
    self.personInfoViewModel.viewController = self;
    
    [self.modifyInfoView.passwordPressSignal subscribeNext:^(id  _Nullable x) {
        [self.navigationController pushViewController:[[ModifyPasswordController alloc] init] animated:YES];
    }];
    
    [self.modifyInfoView.headIconPressSignal subscribeNext:^(id  _Nullable x) {
        [self.personInfoViewModel showPhotoSelectView];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(PersonInfoViewModel *)personInfoViewModel {
    if (!_personInfoViewModel) {
        _personInfoViewModel = [PersonInfoViewModel new];
    }
    return _personInfoViewModel;
}

@end
