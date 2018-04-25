//
//  BookPlayViewController.h
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookData;
@interface BookPlayViewController : UIViewController

@property(nonatomic,strong) NSString *rootUrl;
@property(nonatomic,strong) BookData *bookData;
@property(nonatomic,strong) NSString *bookName;
@end
