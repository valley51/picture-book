//
//  BookData.h
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookData : NSObject

@property(nonatomic,strong) NSString *pagecount;
@property(nonatomic,strong) NSString *mp3url;
@property(nonatomic,strong) NSMutableArray *pages;
@end
