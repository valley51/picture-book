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
    
    if ([UIScreen mainScreen].bounds.size.width>400) {
         self.itemSize=CGSizeMake(180, 180);
    }
    else if([UIScreen mainScreen].bounds.size.width>350){
        self.itemSize=CGSizeMake(160, 160);
    }else{
        self.itemSize=CGSizeMake(140, 140);
    }
    self.minimumInteritemSpacing=10;
    self.minimumLineSpacing=15;
    self.sectionInset=UIEdgeInsetsMake(15, 15, 15, 15);
    self.scrollDirection=UICollectionViewScrollDirectionVertical;
}
@end
