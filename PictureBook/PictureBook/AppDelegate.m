//
//  AppDelegate.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/17.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "AppDelegate.h"
#import "RegisterViewController.h"
#import <UMMobClick/MobClick.h>
#import "HomeViewController.h"
@interface AppDelegate ()
@property(nonatomic,strong) UINavigationController *nav;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置友盟统计
    UMConfigInstance.appKey = @"5ad9a57ff43e48663c0001b2";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy =SEND_INTERVAL;
    [MobClick startWithConfigure:UMConfigInstance];
    NSString *version = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //初始化
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    if (![USER_DEFAULT boolForKey:@"firstTime"]) {
        RegisterViewController *regVC = [[RegisterViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:regVC];
        [nav setNavigationBarHidden:YES];
        self.nav = nav;
        self.window.rootViewController = self.nav;
    }else{
        HomeViewController *home = [[HomeViewController alloc]init];
        self.window.rootViewController = home;
    }
    [self.window makeKeyAndVisible];
    [self loadGoogleAd];
    return YES;
}
-(void)loadGoogleAd{
    // Use Firebase library to configure APIs
    [FIRApp configure];
    // Initialize Google Mobile Ads SDK
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-4903381575382292~9621475125"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
