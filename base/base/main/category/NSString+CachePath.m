//
//  NSString+CachePath.m
//  photo
//
//  Created by 沈雁飞 on 16/3/3.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSString+CachePath.h"

@implementation NSString (CachePath)
+ (NSString *)documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    return documentsPath;
}
+ (NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths firstObject];
    return cachePath;
}
+ (NSString *)tmpPath
{
    NSString *tmpPath = NSTemporaryDirectory();
    return tmpPath;
}
@end
