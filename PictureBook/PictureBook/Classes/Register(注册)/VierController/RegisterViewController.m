//
//  RegisterViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChooseViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
@interface RegisterViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

//跳过按钮
@property(nonatomic,strong) UIButton *skipBtn;
//logo
@property(nonatomic,strong) UIImageView *logo;
@property(nonatomic,strong) UILabel *logoLabel;
//手机号码 输入框
@property(nonatomic,strong) UIImageView *phoneIV;
@property(nonatomic,strong) UITextField *phoneTF;
@property(nonatomic,strong) NSString *phone;
//验证码 输入框
@property(nonatomic,strong) UIImageView *cheakIV;
@property(nonatomic,strong) UITextField *cheakTF;
@property(nonatomic,strong) UIButton *getBtn;
@property(nonatomic,strong) NSString *code;
@property(nonatomic,assign) BOOL finishRegister;
//年龄 输入框
@property(nonatomic,strong) UIImageView *ageIV;
@property(nonatomic,strong) UITextField *ageTF;
@property(nonatomic,strong) UIPickerView *pick;
@property(nonatomic,strong) NSArray *ageArray;

//宝宝昵称
@property(nonatomic,strong) UIImageView *nameIV;
@property(nonatomic,strong) UITextField *nameTF;
@property(nonatomic,strong) NSString *name;
//注册按钮
@property(nonatomic,strong) UIButton *regBtn;

@end

@implementation RegisterViewController
- (NSArray *)ageArray{
    if (_ageArray==nil) {
        _ageArray = @[@"不到4岁",@"4岁",@"5岁",@"6岁",@"7岁",@"8岁",@"9岁",@"10岁",@"11岁",@"12岁",@"12岁以上"];
    }
    return _ageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.finishRegister = NO;
    [self setUp];
    [self setConstraits];
}

/**
 初始化控件
 */
- (void)setUp{
    //背景
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.bounds];
    back.image = kGetImage(@"bg");
    [self.view addSubview:back];
    //跳过按钮
    UIButton *sbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sbtn.frame = CGRectMake(0, 0, 80, 40);
    [sbtn setTitle:@"跳过" forState:UIControlStateNormal];
    [sbtn setTitleColor:RGBColor(166, 100, 70) forState:UIControlStateNormal];
    [sbtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sbtn];
    self.skipBtn = sbtn;
    //logo
    UIImageView *logo = [[UIImageView alloc]initWithImage:kGetImage(@"logo")];
    [self.view addSubview:logo];
    self.logo = logo;
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"请先注册";
    lable.textColor = RGBColor(25, 98, 139);
    self.logoLabel = lable;
    [self.view addSubview:lable];
    //手机号
    UIImageView *phoneIV = [[UIImageView alloc]initWithImage:kGetImage(@"tel")];
    self.phoneIV = phoneIV;
    [self.view addSubview:phoneIV];
    UITextField *phoneTF = [[UITextField alloc]init];
    phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTF.keyboardType = UIKeyboardTypeDecimalPad;
    phoneTF.backgroundColor = [UIColor whiteColor];
    phoneTF.placeholder = @"请输入手机号码";
    phoneTF.tintColor = RGBColor(166, 100, 70);
    phoneTF.delegate = self;
    self.phoneTF = phoneTF;
    [self.view addSubview:phoneTF];
    //验证码
    UIImageView *cheakIV = [[UIImageView alloc]initWithImage:kGetImage(@"blo")];
    self.cheakIV = cheakIV;
    [self.view addSubview:cheakIV];
    UITextField *cheakTF = [[UITextField alloc]init];
    cheakTF.borderStyle = UITextBorderStyleRoundedRect;
    cheakTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    cheakTF.keyboardType = UIKeyboardTypeDecimalPad;
    cheakTF.backgroundColor = [UIColor whiteColor];
    self.cheakTF = cheakTF;
    self.cheakTF.delegate = self;
    [self.view addSubview:cheakTF];
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getBtn.backgroundColor =RGBColor(166, 100, 70);
    [getBtn addTarget:self action:@selector(huoqu) forControlEvents:UIControlEventTouchUpInside];
    [getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getBtn = getBtn;
    [self.view addSubview:getBtn];
    //年龄
    UIImageView *ageIV = [[UIImageView alloc]initWithImage:kGetImage(@"age")];
    self.ageIV = ageIV;
    [self.view addSubview:ageIV];
    UITextField *ageTF = [[UITextField alloc]init];
    ageTF.borderStyle = UITextBorderStyleRoundedRect;
    self.pick = [[UIPickerView alloc]init];
    self.pick.delegate = self;
    self.pick.dataSource = self;
    ageTF.inputView = self.pick;
    ageTF.backgroundColor = [UIColor whiteColor];
    ageTF.placeholder = @"请选择孩子的年龄";
    ageTF.tintColor = ClearColor;
    self.ageTF = ageTF;
    self.ageTF.delegate = self;
    [self.view addSubview:ageTF];
    //宝宝昵称
    UIImageView *nameIV = [[UIImageView alloc]initWithImage:kGetImage(@"name")];
    self.nameIV = nameIV;
    [self.view addSubview:nameIV];
    UITextField *nameTF = [[UITextField alloc]init];
    nameTF.borderStyle = UITextBorderStyleRoundedRect;
    nameTF.backgroundColor = [UIColor whiteColor];
    nameTF.placeholder = @"宝宝昵称";
    nameTF.tintColor = ClearColor;
    self.nameTF = nameTF;
    self.nameTF.delegate = self;
    [self.view addSubview:nameTF];
    //注册按钮
    UIImageView *iv = [[UIImageView alloc] initWithImage:kGetImage(@"button")];
    UIButton *button = [[UIButton alloc] initWithFrame:iv.frame];
    [button setImage:kGetImage(@"button") forState:UIControlStateNormal];;
    [button addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    self.regBtn = button;
    [self.view addSubview:button];
}

/**
 设置约束
 */
- (void)setConstraits{
    CGFloat lineSpace = 30;
    if (iphone5s) {
        lineSpace = 15;
    }
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
    }];
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.phoneIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(32);
        make.right.equalTo(self.phoneTF.left).offset(-10);
        make.top.equalTo(self.logoLabel.bottom).offset(50);
    }];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(screenW*0.6);
        make.height.equalTo(40);
        make.centerX.equalTo(self.view.centerX).offset(20);
        make.top.bottom.equalTo(self.phoneIV);
    }];
    [self.cheakIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(32);
        make.left.equalTo(self.phoneIV);
        make.top.equalTo(self.phoneIV.bottom).offset(lineSpace);
    }];
    [self.cheakTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(screenW*0.3);
        make.height.equalTo(40);
        make.left.equalTo(self.cheakIV.right).offset(10);
        make.top.bottom.equalTo(self.cheakIV);
    }];
    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(screenW*0.3);
        make.height.equalTo(32);
        make.left.equalTo(self.cheakTF.right).offset(2);
        make.top.equalTo(self.cheakTF);
    }];
    [self.ageIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(32);
        make.left.equalTo(self.phoneIV);
        make.top.equalTo(self.cheakIV.bottom).offset(lineSpace);
    }];
    [self.ageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(screenW*0.6);
        make.height.equalTo(40);
        make.left.equalTo(self.ageIV.right).offset(10);
        make.top.bottom.equalTo(self.ageIV);
    }];
    [self.nameIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(32);
        make.left.equalTo(self.phoneIV);
        make.top.equalTo(self.ageTF.bottom).offset(lineSpace);
    }];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(screenW*0.6);
        make.height.equalTo(40);
        make.left.equalTo(self.nameIV.right).offset(10);
        make.top.bottom.equalTo(self.nameIV);
    }];
    [self.regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTF).offset(lineSpace*3);
        make.left.equalTo(self.view).offset((screenW-self.regBtn.frame.size.width)*0.5);
    }];
}
#pragma mark ============picker==============
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 11;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.ageArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.ageTF.text = self.ageArray[row];
}

/**
 退出第一响应者
 */
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.ageTF resignFirstResponder];
    [self.cheakTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
}
#pragma mark ============输入框代理==============
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.phoneTF) {
        self.phone = self.phoneTF.text;
    }else if (textField == self.cheakTF && self.cheakTF.text.length>0){
        
        self.code = self.cheakTF.text;
        [self yanzheng];
    }else if (textField == self.nameTF){
        self.name = self.nameTF.text;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.cheakTF) {
        if (self.phone) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.ageTF) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark ============注册业务逻辑==============
/**
 跳过注册
 */
- (void)skip{
    [USER_DEFAULT setBool:YES forKey:@"firstTime"];
    HomeViewController *home = [[HomeViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:home];
}

/**
 获取验证码
 */
- (void)huoqu{
    [self.phoneTF endEditing:YES];
    if ([self valiMobile:self.phone]) {
        self.getBtn.enabled = NO;
        self.getBtn.backgroundColor = [UIColor colorWithRed:166/255.0 green:100/255.0 blue:70/255.0 alpha:0.7];
        [self.getBtn setTitle:@"已发送" forState:UIControlStateNormal];
        NSDictionary *dic = @{
                              @"phone":self.phone,
                              @"app":@"app2"
                              };
        [YYHttpTool get:@"http://app.52kb.cn:666/get_phone_code" params:dic success:^(id responseObj) {
            NSString *string = responseObj[@"msg"];
            NSLog(@"msg========%@",string);
        } failure:^(NSError *error) {
        }];
    }else{
        [self alertWith:@"请输入正确的手机号"];
    }
}
- (void)yanzheng{
    NSDictionary *dic = @{
                          @"code":self.code,
                          @"phone":self.phone,
                          @"app":@"app2"
                          };
    [YYHttpTool get:@"http://app.52kb.cn:666/verify_phone_code" params:dic success:^(id responseObj) {
        NSString *string = responseObj[@"msg"];
        NSLog(@"yanzheng======%@",string);
        if ([string isEqualToString:@"null"]) {
             self.finishRegister = YES;
            [self successWith:@"验证成功"];
        } else{
            [self alertWith:@"验证码错误"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self alertWith:@"验证失败"];
    }];
}

/**
 判断手机号格式是否正确
 @param mobile 手机号
 @return 正确与否
 */
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
/**
 完成注册
 */
- (void)zhuce{
    if (self.ageTF.text.length>0 && self.finishRegister && self.nameTF.text.length>0) {
        ChooseViewController *choose = [[ChooseViewController alloc]init];
        choose.age = self.ageTF.text;
        choose.phone = self.phone;
        choose.name = self.nameTF.text;
        [self.navigationController pushViewController:choose animated:YES];
    }else if (self.ageTF.text.length>0 && self.nameTF.text.length>0){
        [self alertWith:@"请输入正确的验证码"];
    }else if (self.ageTF.text.length>0){
        [self alertWith:@"为宝宝取个好听的名字吧～"];
    }else{
        [self alertWith:@"请选择宝宝的年龄"];
    }
}

/**
 成功提醒
 */
- (void)successWith:(NSString *)string{
    [SVProgressHUD showSuccessWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
/**
 错误提醒
 */
- (void)alertWith:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
