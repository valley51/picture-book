//
//  MyFlowLayout.m
//  FlowersHerbs
//
//  Created by 陈松松 on 2018/3/19.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout
-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(screenW*0.5-40, (screenW*0.5-40)*1.2);
    self.minimumInteritemSpacing=10;
    self.minimumLineSpacing=15;
    CGFloat space = screenW *0.04;
    self.sectionInset=UIEdgeInsetsMake(space,space, space, space);
    self.scrollDirection=UICollectionViewScrollDirectionVertical;
}
@end
