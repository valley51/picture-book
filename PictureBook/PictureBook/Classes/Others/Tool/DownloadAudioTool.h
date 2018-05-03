//
//  DownloadAudioTool.h
//  PictureBook
//
//  Created by 陈松松 on 2018/4/26.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(NSString *filePath);
typedef void(^Failed)(void);

@interface DownloadAudioTool : NSObject

+ (void)downloadAudioWithUrl:(NSString *)url
           saveDirectoryPath:(NSString *)directoryPath
                    fileName:(NSString *)fileName
                      finish:(FinishBlock )finishBlock
                      failed:(Failed)failed;
@end
