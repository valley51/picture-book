//
//  PictureBook.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/20.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//
#import "PictureBook.h"
@import GoogleMobileAds;
@interface PictureBook()<GADInterstitialDelegate>{
    UIViewController *AdViewController;
}
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong) GADInterstitial *interstitial;
@end
@implementation PictureBook
+ (void)load
{
    [self shareInstance];
}
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance=[[self alloc]init];
    });
    return instance;
}
- (instancetype)init
{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            ///要等DidFinished方法结束后才能初始化UIWindow，不然会检测是否有rootViewController
            if ([USER_DEFAULT boolForKey:@"register"]) {
//                [self show];
//                [self CheakAd];
            }
        }];
        ///进入后台
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
        }];
        ///后台启动,二次开屏广告
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            if ([USER_DEFAULT boolForKey:@"register"]) {
                [self show];
                [self CheakAd];
            }
        }];
    }
    return self;
    
}
- (void)CheakAd{
    self.interstitial=[[GADInterstitial alloc]initWithAdUnitID:@"ca-app-pub-4903381575382292/8088901604"];
    self.interstitial.delegate=self;
    GADRequest *request=[GADRequest request];
    request.testDevices=@[ kGADSimulatorID ];
    [self.interstitial loadRequest:request];
}
- (void)show{
    UIWindow *window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    AdViewController=[UIViewController new];
    window.rootViewController=AdViewController;
    window.rootViewController.view.backgroundColor=[UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled=NO;
    //广告布局
    [self setupSubview:window];
    window.windowLevel=UIWindowLevelStatusBar+1;
    window.hidden=NO;
    window.alpha=1;
    self.window=window;
}
- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.window.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window.subviews.copy enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.window.hidden = YES;
        self.window = nil;
    }];
}
- (void)setupSubview:(UIWindow *)window{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:window.bounds];
    imageView.image=[UIImage imageNamed:@"launch"];
    imageView.contentMode=UIViewContentModeScaleToFill;
    [window addSubview:imageView];
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    [self.interstitial presentFromRootViewController:AdViewController];
}
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    [self hide];
}
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    [self hide];
}

@end
