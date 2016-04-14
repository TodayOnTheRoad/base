//
//  NSArray+Category.m
//  test
//
//  Created by 沈雁飞 on 16/3/9.
//  Copyright © 2016年 沈雁飞. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)
#pragma mark - 构造方法
+ (instancetype)arrayForPlistName:(NSString *)plistName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray *array = [self arrayWithContentsOfFile:filePath];
    return array;
}
@end
