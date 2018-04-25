//
//  MyCoViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "MyCoViewController.h"
#import "MyCoViewCell.h"
#import "Book.h"
#import "MJExtension.h"
#import <SDImageCache.h>
#import "BookPlayViewController.h"
#import "BookData.h"
@interface MyCoViewController ()
@property(nonatomic,strong) NSArray *bookStore;
@end

@implementation MyCoViewController

static NSString * const reuseIdentifier = @"Cell";
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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bookStore.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = kGetImage(@"book");
    cell.cellBook = self.bookStore[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.item);
    //1.获取绘本
    Book *book = self.bookStore[indexPath.item];
    NSDictionary *dic = @{
                          @"method":@"bookinfo",
                          @"bookid":book.bookid
                          };
    [YYHttpTool get:@"http://app.52kb.cn:666/huiben.html" params:dic success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        BookPlayViewController *bookPlay = [[BookPlayViewController alloc]init];
        bookPlay.bookName = book.name;
        bookPlay.rootUrl = responseObj[@"root"];
        NSMutableArray *array = [BookData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        bookPlay.bookData = [array firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:bookPlay animated:YES];
        });
    } failure:^(NSError *error) {
        
    }];
    //2.传递数据
    //3.推出播放页面
    
    
    
    
    
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
