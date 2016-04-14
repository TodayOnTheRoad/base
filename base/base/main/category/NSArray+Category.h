//
//  NSArray+Category.h
//  test
//
//  Created by 沈雁飞 on 16/3/9.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)
#pragma mark - 构造方法
/**
 *  @param plistName 文件名
 *
 *  @return 数组对象
 */
+ (instancetype)arrayForPlistName:(NSString *)plistName;
@end
