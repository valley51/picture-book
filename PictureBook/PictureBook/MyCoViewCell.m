//
//  MyCoViewCell.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/23.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "MyCoViewCell.h"

@implementation MyCoViewCell
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:self.viewForFirstBaselineLayout.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
@end
