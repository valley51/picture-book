//
//  ChooseButton.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "ChooseButton.h"

@implementation ChooseButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        [self setImage:kGetImage(@"d2") forState:UIControlStateNormal];
        [self setImage:kGetImage(@"d1") forState:UIControlStateSelected];
        [self setTitleColor:RGBColor(166, 100, 70) forState:UIControlStateNormal];
        self.imageView.userInteractionEnabled = YES;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  self.selected = !self.selected;
}
@end
