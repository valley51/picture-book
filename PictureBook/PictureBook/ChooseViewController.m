//
//  ChooseViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "ChooseViewController.h"
#import "HomeViewController.h"
#import "ChooseButton.h"
#import "SVProgressHUD.h"
@interface ChooseViewController ()

@property(nonatomic,strong) UIButton *skipBtn;
@property(nonatomic,strong) UILabel *gongxi;
@property(nonatomic,strong) UILabel *tixing;
@property(nonatomic,strong) UILabel *jianyi;

@property(nonatomic,strong) ChooseButton *allBtn;
@property(nonatomic,strong) NSMutableArray *tmp;
@property(nonatomic,strong) UIButton *sureBtn;
//@property(nonatomic,strong) NSString *Okay;

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
    //选择界面
    NSArray *stringArray = @[@"VIPKID 纯北美外教 代言人刘涛",@"哒哒外教 专属外教 代言人孙俪",@"51Talk 高校教材 代言人贾乃亮",@"VipJr 量身定制课 代言人姚明"];
    self.tmp = [NSMutableArray array];
    for (int i =0; i<4; i++) {
        ChooseButton *button = [ChooseButton buttonWithType:UIButtonTypeCustom];
        NSString *string = stringArray[i];
        [button setTitle:string forState:UIControlStateNormal];
        [_tmp addObject:button];
        [self.view addSubview:button];
    }
    ChooseButton *allBtn = [ChooseButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"以上都想试听体验" forState:UIControlStateNormal];
    [self.view addSubview:allBtn];
    self.allBtn = allBtn;
    //确认
    UIImageView *iv = [[UIImageView alloc] initWithImage:kGetImage(@"button")];
    UIButton *button = [[UIButton alloc] initWithFrame:iv.frame];
    [button setImage:kGetImage(@"choose") forState:UIControlStateNormal];;
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
    for (int i = 0; i<4; i++) {
        ChooseButton *button = self.tmp[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jianyi.bottom).offset(20+50*i);
            make.left.equalTo(self.view).offset(50);
        }];
    }
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jianyi.bottom).offset(20+50*4);
        make.left.equalTo(self.view).offset(50);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //需要适配/////////////
        make.top.equalTo(self.allBtn.bottom).offset(100);
        make.centerX.equalTo(self.view);
    }];
}
- (void)skip{
    NSDictionary *dic = @{
                          @"app":@"app2"
                          };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://app.52kb.cn:666/get_shut_count" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    [self completeRegister:@"0"];
}
- (void)sure{
    NSMutableString *organization = [NSMutableString string];
    if (self.allBtn.selected) {
        [organization appendString:[NSString stringWithFormat:@"1234"]];
    }else{
        for (int i = 0; i<4; i++) {
            ChooseButton *button = self.tmp[i];
            if (button.selected) {
                [organization appendString:[NSString stringWithFormat:@"%d",i+1]];
            }
        }
    }
    NSLog(@"%@========%@====%@",self.phone,self.age,organization);
    [self completeRegister:organization];

}
- (void)completeRegister:(NSString *)organization{
    if (organization.length>0) {
        NSDictionary *dic = @{
                              @"age":self.age,
                              @"phone":self.phone,
                              @"organization":organization,
                              @"app":@"app2"
                              };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://app.52kb.cn:666/set_register_info" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *string = responseObject[@"msg"];
            NSLog(@"注册======%@",string);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
        HomeViewController *home = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        [USER_DEFAULT setBool:YES forKey:@"register"];
    }else{
        [self alertWith:@"您还没有选择要试听的机构呢～"];
    }
}
- (void)alertWith:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
@end
