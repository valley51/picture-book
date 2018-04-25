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

@interface HomeViewController ()<UINavigationControllerDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
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
    frame.size.height = 60;
    frame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = frame;
}








@end
