//
//  CoverView.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/28.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

+ (void)show{
    // 1.创建蒙版
    
    CoverView *cover = [[self alloc] init];
    
    // 2.添加蒙版
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    // 3.设置尺寸
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    
}

+ (void)hide{
    // 隐藏蒙版
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[CoverView class]]) {
            // 当前类
            [view removeFromSuperview];
            break;
        }
    }
}

@end
