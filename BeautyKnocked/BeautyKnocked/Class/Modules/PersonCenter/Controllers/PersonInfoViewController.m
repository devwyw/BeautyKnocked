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
#import <ZLPhotoActionSheet.h>

@interface PersonInfoViewController ()

@property (nonatomic, strong) ModifyPersonInfoView *modifyInfoView;

@property (nonatomic, strong) PersonInfoViewModel *personInfoViewModel;

@end

@implementation PersonInfoViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"资料设置";
    self.view.backgroundColor =  [UIColor colorWithHexString:@"#F0F0F0"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createViews];
    [self addConstraints];
    [self dealSignals];
}
-(void)saveDone:(UIButton*)ben{
    
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
    Acount *user=[Acount shareManager];
    [self.modifyInfoView.passwordPressSignal subscribeNext:^(id  _Nullable x) {
        [self.navigationController pushViewController:[[ModifyPasswordController alloc] init] animated:YES];
    }];
    
    Weakify(self);
    [self.modifyInfoView.headIconPressSignal subscribeNext:^(id  _Nullable x) {
        ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
        actionSheet.maxSelectCount = 1;
        actionSheet.showSelectBtn=YES;
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            NSData *imageData=UIImageJPEGRepresentation(images.firstObject, 1.0);
            if (!isObjectEmpty(imageData)) {
                if (imageData.length>1024*1024) {
                    imageData = UIImageJPEGRepresentation(images.firstObject, 0.2);
                }else if (imageData.length>512*1024){
                    imageData = UIImageJPEGRepresentation(images.firstObject, 0.25);
                }else if (imageData.length>256*1024){
                    imageData = UIImageJPEGRepresentation(images.firstObject, 0.5);
                }
                NSLog(@"压缩后:%fK",imageData.length/1024.0f);
                NSString *imageBase = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [Master HttpPostRequestByParams:@{@"id":user.id,@"device":UUID,@"imgStr":imageBase} url:mlqqm serviceCode:ghtx Success:^(id json) {
                    Wself.modifyInfoView.headerimage=images.firstObject;
                    user.headPath=json[@"info"];
                    [Master showSVProgressHUD:@"头像修改成功" withType:ShowSVProgressTypeSuccess withShowBlock:nil];
                } Failure:nil];
            }else{
                [Master showSVProgressHUD:@"请重新选择头像图片" withType:ShowSVProgressTypeSuccess withShowBlock:nil];
            }
        }];
        [actionSheet showPreviewAnimated:YES sender:Wself];
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
