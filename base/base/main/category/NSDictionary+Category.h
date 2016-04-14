//
//  NSDictionary+Category.h
//  test
//
//  Created by 沈雁飞 on 16/3/9.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)
#pragma mark - 构造方法
/**
 *  @param plistName 文件名
 *
 *  @return 字典对象
 */
+ (instancetype)dictionaryForPlistName:(NSString *)plistName;
@end
