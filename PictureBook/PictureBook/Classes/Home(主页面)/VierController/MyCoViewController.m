//
//  MyCoViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "MyCoViewController.h"
#import "MyCoViewCell.h"
#import "BannerCell.h"
#import "Book.h"
#import "MJExtension.h"
#import "BookPlayViewController.h"
#import "BookData.h"
#import "RegisterViewController.h"
#import "SVProgressHUD.h"

@interface MyCoViewController ()

@property(nonatomic,strong) NSArray *bookStore;
@end

@implementation MyCoViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseBanner = @"BannerCell";
- (void)getBookWith:(NSString *)age{
    NSDictionary *dic = @{
                          @"method":@"bookinfos",
                          @"lang":@"2",
                          @"age":age,
                          @"type":@"0"
                          };
        [YYHttpTool get:@"http://app.52kb.cn:666/huiben.html" params:dic success:^(id responseObj) {
            [USER_DEFAULT setValue:responseObj[@"root"] forKey:@"root"];
            NSDictionary *bookDic = responseObj[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            array = [Book mj_objectArrayWithKeyValuesArray:bookDic];
            self.bookStore = [array copy];
            [self.collectionView reloadData];
        } failure:^(NSError *error) {
        }];
}
- (NSArray *)bookStore{
    if (_bookStore==nil) {
        _bookStore = [NSArray array];
    }
    return _bookStore;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = RGBColor(254, 212, 98);
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [self.collectionView registerClass:[MyCoViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:reuseBanner];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger i = self.bookStore.count;
    return i;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([USER_DEFAULT boolForKey:@"register"]){
        NSInteger i = indexPath.item;
        MyCoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.imageView.image = kGetImage(@"book");
        cell.cellBook = self.bookStore[i];
        return cell;
    }else{
        MyCoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.imageView.image = kGetImage(@"book");
        cell.cellBook = self.bookStore[indexPath.item];
        return cell;
    }

}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([USER_DEFAULT boolForKey:@"register"]) {
        NSInteger i = indexPath.item;
        //1.获取绘本
        Book *book = self.bookStore[i];
        NSDictionary *dic = @{
                              @"method":@"bookinfo",
                              @"bookid":book.bookid
                              };
        [SVProgressHUD showWithStatus:@"正在为您加载绘本"];
        [YYHttpTool get:@"http://app.52kb.cn:666/huiben.html" params:dic success:^(id responseObj) {
            BookPlayViewController *bookPlay = [[BookPlayViewController alloc]init];
            //2.传递数据
            bookPlay.bookName = book.name;
            bookPlay.rootUrl = responseObj[@"root"];
            NSMutableArray *array = [BookData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            bookPlay.bookData = [array firstObject];
            //3.推出播放页面
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.navigationController pushViewController:bookPlay animated:YES];
            });
        } failure:^(NSError *error) {
            
        }];

    }else{
        //1.弹出提醒框
        UIAlertController *needRegister = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还没有注册，注册后可查看所有绘本哦～" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAciton = [UIAlertAction actionWithTitle:@"拒绝注册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *goAciton = [UIAlertAction actionWithTitle:@"这就去注册" style:0 handler:^(UIAlertAction * _Nonnull action) {
            RegisterViewController *rvc = [[RegisterViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rvc];
            nav.navigationBar.hidden = YES;
            [self presentViewController:nav animated:YES completion:nil];
        }];
        [needRegister addAction:cancelAciton];
        [needRegister addAction:goAciton];
        //2.点击弹出注册界面
        [self presentViewController:needRegister animated:YES completion:nil];
    }
    

}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}

@end
