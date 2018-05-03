//
//  PlayFlowLayout.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/26.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "PlayFlowLayout.h"

@implementation PlayFlowLayout
- (void)prepareLayout{
    self.itemSize = CGSizeMake(screenW, screenH*0.7);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
