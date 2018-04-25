//
//  BookPlayViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "BookPlayViewController.h"
#import "BookData.h"
#import "SinglePage.h"
#import "MJExtension.h"
@interface BookPlayViewController ()
@property(nonatomic,strong) NSMutableArray<UIImage *> *images;
@end

@implementation BookPlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (NSMutableArray<UIImage *> *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllImages];
    [self setUp];
    NSString *mp3url = [NSString stringWithFormat:@"%@%@",self.rootUrl,self.bookData.mp3url];
    NSLog(@"%@",mp3url);
    // Do any additional setup after loading the view.
}

//界面设置
- (void)setUp{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kGetImage(@"back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kGetImage(@"s") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = self.bookName;
    UIImageView *showImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH*0.6)];
    showImage.backgroundColor = [UIColor whiteColor];
    showImage.contentMode = UIViewContentModeScaleAspectFit;
    showImage.image = self.images[1];
    [self.view addSubview:showImage];
}
/**
 加载图片
 */
- (void)getAllImages{
    NSArray *array = [SinglePage mj_objectArrayWithKeyValuesArray:self.bookData.pages];
    for (SinglePage *page in array) {
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.rootUrl,page.imgUrl]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
        [self.images addObject:image];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
