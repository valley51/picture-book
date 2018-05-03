//
//  HomeViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "HomeViewController.h"
#import "MyFlowLayout.h"
#import "MyCoViewController.h"
#import "CoverView.h"

@interface HomeViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong) UIImage *picImage;
@property(nonatomic,strong) NSString *picUrl;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *swichFlag;
@property(nonatomic,strong) NSString *shutFlag;
@property(nonatomic,strong) UIImageView *picView;
@property(nonatomic,strong) UIButton *shutBtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    if ([USER_DEFAULT boolForKey:@"register"]) {
        [self getAdInfo];
    }
    [self setUp];
}
- (void)setUp{
    //启蒙
    MyCoViewController *cvc1 = [[MyCoViewController alloc]initWithCollectionViewLayout:[[MyFlowLayout alloc]init]];
    [cvc1 getBookWith:@"1"];
    cvc1.navigationItem.title = @"绘本图书馆";
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:cvc1];
    [self addChildViewController:nav1];
    
    //进阶
    MyCoViewController *cvc2 = [[MyCoViewController alloc]initWithCollectionViewLayout:[[MyFlowLayout alloc]init]];
    cvc2.navigationItem.title = @"绘本图书馆";
    [cvc2 getBookWith:@"2"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:cvc2];
    [self addChildViewController:nav2];
    
    //卓越
    MyCoViewController *cvc3 = [[MyCoViewController alloc]initWithCollectionViewLayout:[[MyFlowLayout alloc]init]];
    cvc3.navigationItem.title = @"绘本图书馆";
    [cvc3 getBookWith:@"3"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:cvc3];
    [self addChildViewController:nav3];
    
    //设置tabbar的item样式
    [self setNav:nav1 WithTitle:@"阅读级别1-2" image:@"1" selectedImage:@"1s"];
    [self setNav:nav2 WithTitle:@"阅读级别3-4" image:@"2" selectedImage:@"2s"];
    [self setNav:nav3 WithTitle:@"阅读级别5-6" image:@"3" selectedImage:@"3s"];
}
- (void)getAdInfo{
    
    NSDictionary *dic = @{
                          @"app":@"app2"
                          };
    [YYHttpTool get:@"http://app.52kb.cn:666/get_start_ad_info" params:dic success:^(id responseObj) {

        self.swichFlag = responseObj[@"flag"];
        NSString *imageUrl = responseObj[@"pic"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        self.picImage = [UIImage imageWithData:data];
        self.type = responseObj[@"type"];
        self.picUrl = responseObj[@"url"];
        dispatch_async(dispatch_get_main_queue(), ^{
            //显示广告
            if ([self.swichFlag isEqualToString:@"1"]) {
                [CoverView show];
                [self showAd];
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [YYHttpTool get:@"http://app.52kb.cn:666/get_shut_info" params:dic success:^(id responseObj) {
        self.shutFlag = responseObj[@"flag"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)showAd{
    CGSize size = self.picImage.size;
    CGFloat scale = size.height / size.width;
    UIImageView *picImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW*0.7, screenW*0.7*scale)];
    picImage.image = self.picImage;
    picImage.center = self.view.center;
    picImage.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:picImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
    [picImage addGestureRecognizer:tap];
    UIButton *shutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat y = (screenH - screenW*0.7*scale)*0.5 -27.5;
    shutBtn.frame = CGRectMake(0.85*screenW, y, 27.5,27.5);
    [shutBtn setImage:kGetImage(@"shutBtn") forState:UIControlStateNormal];
    [shutBtn addTarget:self action:@selector(shutAd) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:shutBtn];
    self.picView = picImage;
    self.shutBtn = shutBtn;
}
- (void)shutAd{
    if (self.shutFlag) {
        [self jump];
    }else{
        [self hideAll];
    }
}
-(void)jump{
    NSLog(@"%@",self.type);
    if ([self.type intValue]) {
        NSURL *url = [NSURL URLWithString:self.picUrl];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
        }
        [self hideAll];
    }else{
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        pasteboard.string=self.picUrl;
        NSURL *zhifu=[NSURL URLWithString:@"alipay://"];
        if ([[UIApplication sharedApplication]canOpenURL:zhifu]) {
            [[UIApplication sharedApplication] openURL:zhifu options:nil completionHandler:nil];
        }
        [self hideAll];
    }
}
- (void)hideAll{
    [CoverView hide];
    [_picView removeFromSuperview];
    [_shutBtn removeFromSuperview];
}
/**
 tabbar样式
 */
- (void)setNav:(UINavigationController *)nav WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)sImage{
    [nav.navigationBar setTranslucent:NO];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:[kGetImage(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[kGetImage(sImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateSelected];
    [nav setTabBarItem:item];
}
- (void)viewWillLayoutSubviews{
    CGRect frame = self.tabBar.frame;
    CGFloat barH = 60;
    if (iphoneX) {
        barH = 100;
    }
    frame.size.height = barH;
    frame.origin.y = self.view.frame.size.height - barH;
    self.tabBar.frame = frame;
}








@end
