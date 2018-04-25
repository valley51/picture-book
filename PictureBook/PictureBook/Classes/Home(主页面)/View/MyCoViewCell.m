//
//  MyCoViewCell.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "MyCoViewCell.h"
#import "Book.h"
@interface MyCoViewCell()

@property(nonatomic,strong) UIImageView *bookImage;
@end
@implementation MyCoViewCell
- (void)setCellBook:(Book *)cellBook{
    _cellBook = cellBook;
    if (_imageView.subviews.count) {
        [_imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    NSString *root = [USER_DEFAULT valueForKey:@"root"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",root,self.cellBook.picurl]];
    //封面图片
    UIImage *cellImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIImageView *bookView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 4, width-16, height-54)];
    bookView.userInteractionEnabled = YES;
    bookView.image = cellImage;
    //书名
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(6, height-50, width-16, 40)];
    label.text = _cellBook.name;
    [label setTextAlignment:NSTextAlignmentCenter];
    label.numberOfLines = 0;
    [bookView addSubview:label];
    [_imageView addSubview:bookView];
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:self.viewForFirstBaselineLayout.bounds];
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}








@end
