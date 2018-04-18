//
//  ChooseViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "ChooseViewController.h"
#import "ChooseView.h"
@interface ChooseViewController ()

@property(nonatomic,strong) UIButton *skipBtn;
@property(nonatomic,strong) UILabel *gongxi;
@property(nonatomic,strong) UILabel *tixing;
@property(nonatomic,strong) UILabel *jianyi;

@property(nonatomic,strong) ChooseView *choose;

@property(nonatomic,strong) UIButton *sureBtn;
@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self setConstraint];
    // Do any additional setup after loading the view.
}

- (void)setUp{
    //背景
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.bounds];
    back.image = kGetImage(@"bg");
    [self.view addSubview:back];
    //跳过按钮
    UIButton *sbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sbtn.frame = CGRectMake(0, 0, 60, 30);
    [sbtn setTitle:@"跳过" forState:UIControlStateNormal];
    [sbtn setTitleColor:RGBColor(166, 100, 70) forState:UIControlStateNormal];
    [sbtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sbtn];
    self.skipBtn = sbtn;
    //提醒label
    UILabel *gongxi = [[UILabel alloc]init];
    gongxi.text = @"恭喜您为宝宝领取了价值388元的英语课程";
    gongxi.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    gongxi.textColor = RGBColor(25, 98, 139);
    self.gongxi = gongxi;
    [self.view addSubview:gongxi];
    UILabel *tixing = [[UILabel alloc]init];
    tixing.text = @"温馨提醒";
    tixing.font = [UIFont systemFontOfSize:16 weight:UIFontWeightThin];
    tixing.textColor = RGBColor(25, 98, 139);
    self.tixing = tixing;
    [self.view addSubview:tixing];
    UILabel *jianyi = [[UILabel alloc]init];
    jianyi.text = @"建议试听多家，多对比对您的选择有更大帮助。";
    jianyi.font = [UIFont systemFontOfSize:16 weight:UIFontWeightThin];
    jianyi.textColor = RGBColor(25, 98, 139);
    self.jianyi = jianyi;
    [self.view addSubview:jianyi];
    //选择框
    ChooseView *choose = [[ChooseView alloc]initWithFrame:CGRectMake(0, 0, screenW-60, 300)];
    [self.view addSubview:choose];
    self.choose = choose;
    //确认
    UIImageView *iv = [[UIImageView alloc] initWithImage:kGetImage(@"button")];
    UIButton *button = [[UIButton alloc] initWithFrame:iv.frame];
    [button setImage:kGetImage(@"button") forState:UIControlStateNormal];;
    [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    self.sureBtn = button;
    [self.view addSubview:button];
}
- (void)setConstraint{
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(20);
        make.right.equalTo(self.view.right).offset(-20);
    }];
    [self.gongxi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view).offset(20);
    }];
    [self.tixing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gongxi.bottom).offset(40);
        make.left.equalTo(self.view).offset(20);
    }];
    [self.jianyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tixing.bottom).offset(5);
        make.left.equalTo(self.view).offset(20);
    }];
    [self.choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.equalTo(self.jianyi.bottom).offset(40);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //需要适配/////////////
        make.bottom.equalTo(self.view).offset(-100);
        make.left.equalTo(self.view).offset((screenW-self.sureBtn.frame.size.width)*0.5);
    }];
}
- (void)skip{
    
}
-(void)sure{
    NSLog(@"%s",__func__);
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
