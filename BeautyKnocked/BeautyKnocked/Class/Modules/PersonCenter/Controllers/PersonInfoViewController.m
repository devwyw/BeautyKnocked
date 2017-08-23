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
#import <ZLPhotoActionSheet.h>

@interface PersonInfoViewController ()

@property (nonatomic, strong) ModifyPersonInfoView *modifyInfoView;

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
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(809));
    }];
}
-(void)dealSignals {
    Acount *user=[Acount shareManager];
    Weakify(self);
    [self.modifyInfoView.passwordPressSignal subscribeNext:^(id  _Nullable x) {
        [Wself.navigationController pushViewController:[[ModifyPasswordController alloc] init] animated:YES];
    }];
    
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
                    /** 修改头像 */
                    Wself.modifyInfoView.headerimage=images.firstObject;
                    user.headPath=json[@"info"];
                    [user UpdateAcount];
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

@end
