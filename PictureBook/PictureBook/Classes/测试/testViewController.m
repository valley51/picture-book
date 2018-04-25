//
//  testViewController.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "testViewController.h"
#import <SDWebImage/SDWebImageDownloader.h>
@interface testViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UIImageView *imge;
@property(nonatomic,strong) UIImage *image;

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *imge = [UIImage imageNamed:@"book"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ojat50mij.bkt.clouddn.com/books/51681/6e9814b5-8e9e-4503-b3b1-d1d98d835456.jpg"]];
    self.testImage.image = [self cellImageWithUrl:url backgroundImage:imge];
    self.imge.image = _image;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)cellImageWithUrl:(NSURL *)url backgroundImage:(UIImage *)background{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
