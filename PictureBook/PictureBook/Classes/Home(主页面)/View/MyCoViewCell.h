//
//  MyCoViewCell.h
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Book;
@interface MyCoViewCell : UICollectionViewCell

@property(nonatomic,assign) BOOL adCell;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) Book *cellBook;

@end
