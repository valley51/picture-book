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
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:cvc1];
    //item
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"阅读级别1-2" image:[kGetImage(@"1") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[kGetImage(@"1s") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateSelected];
    [nav1 setTabBarItem:item1];
    [self addChildViewController:nav1];
    
    //进阶
    MyCoViewController *cvc2 = [[MyCoViewController alloc]initWithCollectionViewLayout:[[MyFlowLayout alloc]init]];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:cvc2];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"阅读级别3-4" image:[kGetImage(@"2") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[kGetImage(@"2s") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateSelected];
    [nav2 setTabBarItem:item2];
    [self addChildViewController:nav2];
    
    //卓越
    MyCoViewController *cvc3 = [[MyCoViewController alloc]initWithCollectionViewLayout:[[MyFlowLayout alloc]init]];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:cvc3];
    
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"阅读级别5-6" image:[kGetImage(@"3") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[kGetImage(@"3s") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateNormal];
    [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0, 0, 0)} forState:UIControlStateSelected];
    [nav3 setTabBarItem:item3];
    [self addChildViewController:nav3];
}
- (void)viewWillLayoutSubviews{
    CGRect frame = self.tabBar.frame;
    frame.size.height = 60;
    frame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = frame;
}








@end
