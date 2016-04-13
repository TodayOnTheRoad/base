//
//  AppCacheManager.h
//  SDWebImageTest
//
//  Created by 沈雁飞 on 16/3/1.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CacheManagerComplete)();
@interface AppCacheManager : NSObject
+(instancetype)shareManager;
/**
 *  清理缓存
 */
- (void)clearDisk;
/**
 *  清除硬盘上的缓存
 *
 *  @param completion 完成后的回调
 */
- (void)clearDiskWithCompletion:(CacheManagerComplete)completion;
/**
 *  需要清理的缓存大小
 *
 *  @return 单位:B
 */
- (NSUInteger)getSize;
@end
