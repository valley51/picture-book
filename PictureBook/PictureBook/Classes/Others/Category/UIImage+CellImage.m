//
//  UIImage+CellImage.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "UIImage+CellImage.h"
#import <SDWebImage/SDWebImageDownloader.h>

@implementation UIImage (CellImage)
+ (UIImage *)cellImageWithUrl:(NSURL *)url backgroundImage:(UIImage *)background{
    CGSize size = background.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [background drawAtPoint:CGPointZero];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *Image = [UIImage imageWithData:data];
    [Image drawInRect:CGRectMake(2, 2, 150, 150)];
    UIImage *cellImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cellImage;
}
@end
