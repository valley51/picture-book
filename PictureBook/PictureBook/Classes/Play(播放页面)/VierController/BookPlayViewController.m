//
//  BookPlayViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "BookPlayViewController.h"
#import "BookData.h"
#import "SinglePage.h"
#import "MJExtension.h"
#import "PlayFlowLayout.h"
#import "MyCoViewCell.h"

static NSString * const reuseID = @"PlayCell";
@interface BookPlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GADInterstitialDelegate>

@property(nonatomic,strong) GADInterstitial *interstitial;

//@property(nonatomic,strong) AVAudioPlayer *audio;
@property(nonatomic,strong) AVPlayer *player;
@property(nonatomic,strong) UICollectionView *playView;
@property(nonatomic,strong) NSMutableArray<UIImage *> *images;
@property(nonatomic,strong) NSMutableArray<NSValue *> *times;
@property(nonatomic,assign) NSInteger pageCount;
@property(nonatomic,assign) NSInteger currenPage;
@property(nonatomic,strong) UILabel *pageLabel;
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;

@property(nonatomic,assign) int adCount;
@property(nonatomic,strong) id timeObserver;
@end

@implementation BookPlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [_player pause];
}
- (NSMutableArray<UIImage *> *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (NSMutableArray<NSValue *> *)times{
    if (_times == nil) {
        _times = [NSMutableArray array];
    }
    return _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllData];
    [self setUp];
    [self setInterstitial];
    _adCount = 0;
    NSString *mp3url = [NSString stringWithFormat:@"%@%@",self.rootUrl,self.bookData.mp3url];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:mp3url]];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:mp3url]];
    [player replaceCurrentItemWithPlayerItem:item];
    _player = player;
    [self showAD];
    [self changeTime];
    [_player play];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self->_player pause];
    }];
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [_player addBoundaryTimeObserverForTimes:_times queue:dispatch_get_main_queue() usingBlock:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.player pause];
        }
    }];
}

//界面设置
- (void)setUp{
    //导航按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kGetImage(@"back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kGetImage(@"s") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.title = self.bookName;
    
    //展示界面
    PlayFlowLayout *layout = [[PlayFlowLayout alloc]init];
    UICollectionView *playView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH*0.7) collectionViewLayout:layout];
    [playView registerClass:[MyCoViewCell class] forCellWithReuseIdentifier:reuseID];
    playView.delegate = self;
    playView.dataSource = self;
    playView.backgroundColor = [UIColor whiteColor];
    playView.bounces = NO;
    playView.showsHorizontalScrollIndicator = NO;
    playView.showsVerticalScrollIndicator = NO;
    playView.pagingEnabled = YES;
    [self.view addSubview:playView];
    self.playView = playView;
    
    //页码
    self.currenPage = 0;
    UILabel *pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 40)];
    pageLabel.font = [UIFont systemFontOfSize:20];
    [pageLabel setTextAlignment:NSTextAlignmentCenter];
    pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currenPage +1,(long)self.pageCount];
    pageLabel.adjustsFontSizeToFitWidth = YES;
    pageLabel.center = CGPointMake(screenW*0.5, screenH*0.8);
    [self.view addSubview:pageLabel];
    self.pageLabel = pageLabel;
    
    //上一页按钮
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 72.5, 31.5)];
    leftButton.center = CGPointMake(screenW*0.25, screenH*0.8);
    [leftButton setImage:kGetImage(@"last") forState:UIControlStateNormal];
    [leftButton setImage:kGetImage(@"last") forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(pageUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    leftButton.enabled = NO;
    self.leftButton = leftButton;
    //下一页按钮
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 73, 32)];
    rightButton.center = CGPointMake(screenW*0.75, screenH*0.8);
    [rightButton setImage:kGetImage(@"next") forState:UIControlStateNormal];
    [rightButton setImage:kGetImage(@"next") forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(pageDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    self.rightButton = rightButton;
}

- (void)pageUp{
    CGFloat x = self.playView.contentOffset.x - screenW;
    CGFloat y =self.playView.contentOffset.y;
    [self.playView setContentOffset:CGPointMake(x, y) animated:YES];
    self.currenPage -=1;
    [self showAD];
    [self setButtonEnabled];
    [self changeTime];
}
- (void)pageDown{
    CGFloat x = self.playView.contentOffset.x + screenW;
    CGFloat y =self.playView.contentOffset.y;
    [self.playView setContentOffset:CGPointMake(x, y) animated:YES];
    self.currenPage +=1;
    [self showAD];
    [self setButtonEnabled];
    [self changeTime];
}
- (void)showAD{
    self.adCount += 1;
    if (_adCount%5==0) {
        [_player pause];
       [self.interstitial presentFromRootViewController:self];
    }else{
        [_player play];
    }
}
#pragma mark ============datasoure==============

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.imageView.image = self.images[indexPath.item];
    return cell;
}

#pragma mark ============delegate==============

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currenPage = offsetX/screenW;
    [self showAD];
    [self setButtonEnabled];
    [self changeTime];
}
- (void)changeTime{
    if (_currenPage >=0) {
        NSValue *timeValue = self.times[_currenPage];
        CMTime timeCM = [timeValue CMTimeValue];
        [self.player seekToTime:timeCM];
    }
}
/**
 设置按钮状态及页码
 */
- (void)setButtonEnabled{
    if (self.currenPage >=_pageCount-1) {
        self.rightButton.enabled =NO;
    }else if (self.currenPage >0) {
        self.rightButton.enabled = YES;
        self.leftButton.enabled = YES;
    }else{
        self.leftButton.enabled = NO;
    }
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.currenPage +1,self.pageCount];
}
/**
 加载图片
 */
- (void)getAllData{
    NSArray *array = [SinglePage mj_objectArrayWithKeyValuesArray:self.bookData.pages];
    NSURL *URL;
    UIImage *image;
    NSString *endMin;
    NSString *endSec;
    float seconds;
    CMTime secondTime;
    NSValue *time;
//    CMTime secondTime = CMTimeMakeWithSeconds(0, 600);
//    NSValue *time = [NSValue valueWithCMTime:secondTime];
//    [self.times addObject:time];
    for (SinglePage *page in array) {
        //加载图片
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.rootUrl,page.imgUrl]];
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
        [self.images addObject:image];
        //加载时间戳
        endMin = [page.soundBegin substringWithRange:NSMakeRange(0, 1)];
        endSec = [page.soundBegin substringWithRange:NSMakeRange(2, 6)];
        seconds = [endSec floatValue] + [endMin floatValue]*60;
        NSLog(@"=================%f",seconds);
        secondTime = CMTimeMakeWithSeconds(seconds, 600);
        time = [NSValue valueWithCMTime:secondTime];
        [self.times addObject:time];
    }
    self.pageCount = self.images.count;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [_player removeTimeObserver:_timeObserver];
}
#pragma mark ============广告==============
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
}
-(GADInterstitial *)setInterstitial
{
    self.interstitial=[[GADInterstitial alloc]initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    self.interstitial.delegate=self;
    GADRequest *request=[GADRequest request];
    [self.interstitial loadRequest:request];
    return self.interstitial;
}
-(void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [_player play];
    self.interstitial=[self setInterstitial];
}


@end
