//
//  BannerCell.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/28.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "BannerCell.h"

@implementation BannerCell

-(UIImageView *)imageView
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:self.viewForFirstBaselineLayout.bounds];
        _imageView.userInteractionEnabled = YES;
        GADBannerView *ban = [[GADBannerView alloc]initWithFrame:CGRectMake(6, 4, width-16, height-54)];
        ban.adUnitID = @"ca-app-pub-4903381575382292/5079594880";
        ban.rootViewController = self;
        GADRequest *re = [GADRequest request];
        [ban loadRequest:re];
        [_imageView addSubview:ban];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, height-50, width-16, 40)];
        label.text = @"去看看";
        label.adjustsFontSizeToFitWidth = YES;
        [label setTextAlignment:NSTextAlignmentCenter];
        [_imageView addSubview:label];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
@end
