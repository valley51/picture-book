//
//  ChooseView.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/18.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "ChooseView.h"
#import "ChooseButton.h"

@interface ChooseView ()

@property(nonatomic,strong) ChooseButton *button1;
@property(nonatomic,strong) NSArray<ChooseButton *> *array;
@end
@implementation ChooseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *stringArray = @[@"VIPKID 纯北美外教 代言人刘涛",@"哒哒外教 专属外教 代言人孙俪",@"51Talk 高校教材 代言人贾乃亮",@"VipJr 量身定制课 代言人姚明",@"以上都想试听体验"];
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i =0; i<5; i++) {
            ChooseButton *button= [[ChooseButton alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
            NSString *string = stringArray[i];
            [button setTitle:string forState:UIControlStateNormal];
            [button addTarget:self action:@selector(xuanze:) forControlEvents:UIControlEventAllTouchEvents];
            [tmp addObject:button];
            [self addSubview:button];
        }
        self.array = tmp;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i<5; i++) {
        ChooseButton *button = self.array[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20+50*i);
            make.left.equalTo(self);
        }];
    }
}
-(void)xuanze:(ChooseButton *)button{
    button.selected = !button.selected;
}








@end
