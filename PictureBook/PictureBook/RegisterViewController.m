//
//  RegisterViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChooseViewController.h"
@interface RegisterViewController ()

//跳过按钮
@property(nonatomic,strong) UIButton *skipBtn;
//logo
@property(nonatomic,strong) UIImageView *logo;
@property(nonatomic,strong) UILabel *logoLabel;
//手机号码 输入框
@property(nonatomic,strong) UIImageView *phoneIV;
@property(nonatomic,strong) UITextField *phoneTF;
//验证码 输入框
@property(nonatomic,strong) UIImageView *cheakIV;
@property(nonatomic,strong) UITextField *cheakTF;
@property(nonatomic,strong) UIButton *getBtn;
//年龄 输入框
@property(nonatomic,strong) UIImageView *ageIV;
@property(nonatomic,strong) UITextField *ageTF;
//注册按钮
@property(nonatomic,strong) UIButton *regBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    phoneTF.placeholder = @"请输入手机号码                          ";
    phoneTF.tintColor = RGBColor(166, 100, 70);
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
    cheakTF.placeholder = @"                                 ";
    self.cheakTF = cheakTF;
    [self.view addSubview:cheakTF];
    UIButton *cheakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cheakBtn.frame = CGRectMake(0, 0, 100, 38);
    cheakBtn.backgroundColor =RGBColor(166, 100, 70);
    [cheakBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [cheakBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getBtn = cheakBtn;
    [self.view addSubview:cheakBtn];
    //年龄
    UIImageView *ageIV = [[UIImageView alloc]initWithImage:kGetImage(@"age")];
    self.ageIV = ageIV;
    [self.view addSubview:ageIV];
    UITextField *ageTF = [[UITextField alloc]init];
    ageTF.borderStyle = UITextBorderStyleRoundedRect;
    ageTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    ageTF.keyboardType = UIKeyboardTypeDecimalPad;
    ageTF.backgroundColor = [UIColor whiteColor];
    ageTF.placeholder = @"请选择孩子的年龄                         ";
    self.ageTF = ageTF;
    [self.view addSubview:ageTF];
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
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.logoLabel.bottom).offset(50);
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneIV.right).offset(20);
        make.top.bottom.equalTo(self.phoneIV);
    }];
    [self.cheakIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.phoneIV.bottom).offset(30);
    }];
    [self.cheakTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cheakIV.right).offset(20);
         make.top.bottom.equalTo(self.cheakIV);
    }];
    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cheakTF.right).offset(2);
        make.top.equalTo(self.cheakTF);
    }];
    [self.ageIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.cheakIV.bottom).offset(30);
    }];
    [self.ageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ageIV.right).offset(20);
        make.top.bottom.equalTo(self.ageIV);
    }];
    [self.regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ageTF).offset(100);
        make.left.equalTo(self.view).offset((screenW-self.regBtn.frame.size.width)*0.5);
    }];
}
/**
 跳过注册
 */
- (void)skip{
    NSLog(@"%s",__func__);
}

/**
 注册
 */
- (void)zhuce{
    NSLog(@"%s",__func__);
    ChooseViewController *choose = [[ChooseViewController alloc]init];
    [self.navigationController pushViewController:choose animated:YES];
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
