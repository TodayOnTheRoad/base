//
//  AppCacheManager.m
//
//  Created by 沈雁飞 on 16/3/1.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "AppCacheManager.h"
@interface AppCacheManager ()
@property(nonatomic,strong)dispatch_queue_t ioQueue;
@property(nonatomic,strong)NSArray *shouldClearCaches;
@end

@implementation AppCacheManager
{
    NSString  *_diskCachePath;
    NSFileManager *_fileManager;
    
}
+(instancetype)shareManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
-(instancetype)init
{
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = paths[0];
        _ioQueue = dispatch_queue_create("com.cache.app", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
    }
    return self;
}
-(NSArray *)shouldClearCaches
{
    if (_shouldClearCaches == nil) {
        NSString *should = @"photo";
        _shouldClearCaches = [NSArray arrayWithObjects:should, nil];
    }
    return _shouldClearCaches;
}
- (void)clearDisk {
    [self clearDiskWithCompletion:nil];
}

- (void)clearDiskWithCompletion:(CacheManagerComplete)completion
{
    dispatch_async(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:_diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            if (![self.shouldClearCaches containsObject:fileName]) {
                continue;
            }
            [self clearFolderWithFileName:fileName];
        }
        //SDImageCache
//        [self clearSDWebImage];

        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}
- (void)clearFolderWithFileName:(NSString *)fileName
{
    NSString *path = [_diskCachePath stringByAppendingPathComponent:fileName];
    [_fileManager removeItemAtPath:path error:nil];
    [_fileManager createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:NULL];
    
}
- (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:_diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            if (![self.shouldClearCaches containsObject:fileName]) {
                continue;
            }
            size += [self getFolderSizeWithFileName:fileName];
        }
        //SDImageCache
//        size += [self imageClearSize];
    });

    return size;
}
- (NSUInteger)getFolderSizeWithFileName:(NSString *)fileName
{
    NSString *path = [_diskCachePath stringByAppendingPathComponent:fileName];
    NSUInteger contentSize = 0;
    NSDirectoryEnumerator *enumerator = [_fileManager enumeratorAtPath:path];
    for (NSString *fileName in enumerator) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        contentSize += [attrs fileSize];
        }
    return contentSize;
}
#pragma mark - SDImageCache
//- (void)clearSDWebImage
//{
//    [[SDImageCache sharedImageCache] cleanDisk];
//}
//- (NSUInteger)imageClearSize
//{
//    return [[SDImageCache sharedImageCache] getSize];
//}
@end
