//
//  EditAddressController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EditAddressController.h"
#import "AddressEditView.h"
#import "UIButton+Category.h"
#import "AddressModel.h"
#import "UITextField+Length.h"

@interface EditAddressController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) AddressEditView *customerNameView;
@property (nonatomic, strong) AddressEditView *telePhoneView;
@property (nonatomic, strong) AddressEditView *serviceCityView;
@property (nonatomic, strong) AddressEditView *serviceAddressView;

@property (nonatomic, strong) UIPickerView * pickview;
@property (nonatomic, strong) NSArray * leftData;
@property (nonatomic, strong) NSArray * rightData;
@property (nonatomic, copy) NSString * selectComponent;

@property (nonatomic, strong) UIView * whiteview;
@property (nonatomic, strong) UITextView *houseNumberView;
@property (nonatomic, strong) UILabel * topTitle;

@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton * item;
@end

@implementation EditAddressController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        _item = [[UIButton alloc]initWithFrame:CGRectMake(Width-50, 2, 40, 40)];
        [_item setTitle:@"保存" forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        Weakify(self);
        [[_item rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (_customerNameView.content.length>=2&&_telePhoneView.content.length==11&&_serviceAddressView.content.length>=4&&_houseNumberView.text.length>=5) {
                Wself.model.name=_customerNameView.content;
                Wself.model.phone=_telePhoneView.content;
                Wself.model.address=[NSString stringWithFormat:@"%@-%@-%@",_serviceCityView.content,_serviceAddressView.content,_houseNumberView.text];
                Wself.model.isDefault=_defaultButton.isSelected ? @"1":@"0";
                [Wself loadHttpData:Wself.model withAddressEditStyle:self.editStyle];
            }else{
                if (_customerNameView.content.length<2) {
                    [Master showSVProgressHUD:@"请输入真实姓名" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_telePhoneView.content.length!=11){
                    [Master showSVProgressHUD:@"请输入有效的11位手机号" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_serviceAddressView.content.length==0) {
                    [Master showSVProgressHUD:@"请选择一个区域及街道" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (_houseNumberView.text.length<5){
                    [Master showSVProgressHUD:@"请输入不少于5个字的详细地址" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }
            }
        }];
        [self.navigationController.navigationBar addSubview:_item];
    }
}
-(AddressModel*)model{
    if (!_model) {
        _model=[[AddressModel alloc]init];
    }
    return _model;
}
-(NSArray*)leftData{
    if (!_leftData) {
        _leftData=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"]];
        self.rightData=[[NSArray alloc]initWithArray:_leftData[0][@"street"]];
    }
    return _leftData;
}
-(UIPickerView*)pickview{
    if (!_pickview) {
        _pickview=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, Width-100, 120)];
        _pickview.delegate=self;
        _pickview.dataSource=self;
        self.selectComponent=[NSString stringWithFormat:@"%@%@",self.leftData[0][@"eare"],self.rightData.firstObject];
    }
    return _pickview;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item removeFromSuperview];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    
    [self initializeViews];
    [self addConstraints];
}
-(void)initializeViews {
    _customerNameView = [self createAddressViewWithTitle:@"顾客姓名" placeholder:@"请输入姓名"];
    [_customerNameView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _telePhoneView = [self createAddressViewWithTitle:@"手机号码" placeholder:@"请输入手机号码"];
    _telePhoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    _telePhoneView.textField.delegate=self;
    [[_telePhoneView.textField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_telePhoneView.textField setFieldtext:11];
    }];
    
    _serviceCityView = [self createAddressViewWithTitle:@"服务城市" placeholder:@"默认南昌"];
    _serviceCityView.content = @"南昌";
    _serviceCityView.userInteractionEnabled=NO;
    
    _serviceAddressView = [self createAddressViewWithTitle:@"服务街道" placeholder:@"精确到区名-街道名"];
    _serviceAddressView.textField.delegate=self;
    
    _whiteview=[[UIView alloc]init];
    _whiteview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_whiteview];
    
    _houseNumberView = [[UITextView alloc]init];
    _houseNumberView.font=[UIFont systemFontOfSize:Font_Size(40)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeText:) name:UITextViewTextDidChangeNotification object:nil];
    [_whiteview addSubview:_houseNumberView];
    
    _topTitle=[[UILabel alloc]initWithFrame:CGRectMake(5,3, Width-30, Font_Size(35)*2)];
    _topTitle.font=[UIFont systemFontOfSize:Font_Size(40)];
    _topTitle.text=@"请填写详细地址，不少于5个字";
    _topTitle.textColor=[UIColor lightGrayColor];
    [_houseNumberView addSubview:_topTitle];
    
    _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultButton setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_defaultButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_defaultButton setTitle:@"设置为默认收货地址" forState:UIControlStateNormal];
    _defaultButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_defaultButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_defaultButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:[UIImage imageNamed:@"weixuanzhong"].size space:5];
    [[_defaultButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable button) {
        button.selected = !button.selected;
    }];
    
    NSArray *titles = @[@"新增地址",@"修改地址",@"选择地址"];
    self.title = [titles objectAtIndex:_editStyle];
    
    if (_editStyle == AddressEditStyleUpdate) {
        _customerNameView.content = _model.name;
        _telePhoneView.content = _model.phone;
        NSArray *addressArray=[[NSArray alloc]init];
        addressArray=[_model.address componentsSeparatedByString:@"-"];
        _serviceCityView.content = addressArray[0];
        _serviceAddressView.content = addressArray[1];
        _houseNumberView.text = addressArray[2];
        _topTitle.hidden=YES;
        _defaultButton.selected = [_model.isDefault integerValue]==1 ? YES:NO;
    }

    [self.view addSubview:_customerNameView];
    [self.view addSubview:_telePhoneView];
    [self.view addSubview:_serviceCityView];
    [self.view addSubview:_serviceAddressView];
    [self.view addSubview:_defaultButton];
}
-(void)ChangeText:(NSNotification *)not{
    if (_houseNumberView.text.length==0) {
        _topTitle.hidden=NO;
    }else{
        _topTitle.hidden=YES;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    if (textField==_serviceAddressView.textField) {
        [textField resignFirstResponder];
        [LEEAlert alert].config
        .LeeAddCustomView(^(LEECustomView *custom) {
            custom.view=self.pickview;
        })
        .LeeCancelAction(@"取消", nil)
        .LeeAction(@"确认", ^{
            _serviceAddressView.content=self.selectComponent;
        })
        .LeeShow();
        return NO;
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_telePhoneView.textField) {
        return [textField setRange:range whitString:string whitCount:11];
    }else{
        return YES;
    }
}
- (void)textFieldDidChange:(UITextField *)textField
{
    int length = 4;
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
        if (textField.text.length >=20) {
            textField.text=[textField.text substringToIndex:20];
        }
    }
}
-(void)addConstraints {
    NSArray *views = @[_customerNameView,_telePhoneView,_serviceCityView,_serviceAddressView];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(135));
    }];
    
    [_customerNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    
    [_telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customerNameView.mas_bottom);
    }];
    
    [_serviceCityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telePhoneView.mas_bottom);
    }];
    
    [_serviceAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceCityView.mas_bottom);
    }];
    
    [_whiteview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceAddressView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.offset(Height_Pt(300));
    }];
    
    [_houseNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteview);
        make.left.right.equalTo(_whiteview).offset(15);
        make.right.equalTo(_whiteview).offset(-15);
        make.bottom.equalTo(_whiteview);
    }];
    
    [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteview.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(self.view).with.offset(Width_Pt(50));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(500), Height_Pt(55)));
    }];
}
#pragma mark ===== UIPickView =====

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    switch (component) {
        case 0:
            rows = self.leftData.count;
            break;
        case 1:
            rows = self.rightData.count;
            break;
        default:
            break;
    }
    return rows;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.leftData[row][@"eare"];
            break;
        case 1:
            title = self.rightData[row];
            break;
        default:
            break;
    }
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            self.rightData = self.leftData[row][@"street"];
            self.selectComponent=[NSString stringWithFormat:@"%@%@",self.leftData[[_pickview selectedRowInComponent:0]][@"eare"],self.rightData[0]];
            [self.pickview reloadComponent:1];
            break;
        case 1:
            self.selectComponent=[NSString stringWithFormat:@"%@%@",self.leftData[[_pickview selectedRowInComponent:0]][@"eare"],self.rightData[[_pickview selectedRowInComponent:1]]];
            break;
        default:
            break;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc]init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(void)loadHttpData:(AddressModel*)model withAddressEditStyle:(AddressEditStyle)type{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:model.mj_keyValues];
    [dict setObject:UUID forKey:@"device"];
    [dict setObject:[Acount shareManager].id forKey:@"clientId"];
    
    NSString *code=[[NSString alloc]init];
    NSString *message=[[NSString alloc]init];
    switch (type) {
        case AddressEditStyleAddNew:
        {
            code=xzfwdz;
            message=@"添加成功";
            [dict removeObjectForKey:@"id"];
        }
            break;
        case AddressEditStyleUpdate:
        {
            code=xgfwdz;
            message=@"修改成功";
        }
            break;
        default:
            break;
    }
    
    [Master HttpPostRequestByParams:dict url:mlqqm serviceCode:code Success:^(id json) {
        [Master showSVProgressHUD:message withType:ShowSVProgressTypeSuccess withShowBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } Failure:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AddressEditView *)createAddressViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    AddressEditView *addressView = [[AddressEditView alloc] init];
    addressView.placeholder =  placeholder;
    addressView.title = title;
    return addressView;
}
@end
