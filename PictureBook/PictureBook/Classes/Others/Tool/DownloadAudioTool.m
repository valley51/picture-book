//
//  DownloadAudioTool.m
//  PictureBook
//
//  Created by 陈松松 on 2018/4/26.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import "DownloadAudioTool.h"

@implementation DownloadAudioTool
+ (void)downloadAudioWithUrl:(NSString *)url
           saveDirectoryPath:(NSString *)directoryPath
                    fileName:(NSString *)fileName
                      finish:(FinishBlock )finishBlock
                      failed:(Failed)failed
{
    NSString *file_path = [directoryPath stringByAppendingPathComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    /// 判断文件是否已经存在
    if ([fm fileExistsAtPath:file_path])
    {
        finishBlock(file_path);
    }
    /// 不存在时
    else
    {
        NSURL *URL = [NSURL URLWithString:url];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //AFN3.0+基于封住URLSession的句柄
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        //请求
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        //下载Task操作
        NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //进度
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            NSString *file_path = [filePath path];
            finishBlock(file_path);
        }];
        [_downloadTask resume];
    }
}
@end
