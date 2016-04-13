//
//  NSString+CachePath.h
//
//  Created by 沈雁飞 on 16/3/3.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CachePath)
/**
 *  documents路径
 *
 *  @return documents路径
 */
+ (NSString *)documentsPath;
/**
 *  cache路径
 *
 *  @return cache 路径
 */
+ (NSString *)cachePath;
/**
 *  tmp路径
 *
 *  @return tmp路径
 */
+ (NSString *)tmpPath;
@end
